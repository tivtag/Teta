require_relative '../lib/command_history'

describe CommandHistory do
  
  it 'has a maximum size' do
    CommandHistory::MAXIMUM_SIZE.should == 10
  end

  let(:history) { CommandHistory.new }
  subject { history }
  
  context 'when untouched' do
    its(:size) { should == 0 }
    
    describe 'after adding a command' do

      let(:command) { "goto window" }
      before { history.add command }

      its(:size) { should == 1 }

      it 'has the command on top' do
        history.first.should == command
      end
    end

    describe 'after adding multiple commands' do
      
      let(:commands) { ["goto window", "inv", "bogus", "go back"] }
      before do
        commands.each {|command| history.add command} 
      end

      its(:size) { should == commands.size }

      it 'has the commands in order' do
        history.to_a.should == commands
      end

    end

  end
  
  context 'when adding the maximum number of allowed commands' do

    let(:commands) do
      (0...CommandHistory::MAXIMUM_SIZE).map {|i| i.to_s}
    end

    before do
      commands.each {|command| history.add command }
    end

    its(:size) { should == CommandHistory::MAXIMUM_SIZE }

    describe 'after adding another set of commands' do

      let(:other_commands) { ["goto window", "inv", "go b"] } 
      before do
        other_commands.each {|command| history.add command}
      end

      its(:size) { should == CommandHistory::MAXIMUM_SIZE }

      it 'forgot the oldest commands to make room for the new commands' do
        expected_commands = commands.drop(other_commands.size) + other_commands
        history.to_a.should == expected_commands
      end
    end

  end

end
