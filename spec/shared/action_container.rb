
shared_examples_for 'an ActionContainer' do

  let(:container) { described_class.new() }
  subject { container }

  context 'when initialized' do
    it { should_not have_action(:any) }

    it "raises an error when evaluating any action" do
      lambda { container.eval_action(:any) }.should raise_error
    end     
  end

  context 'after adding an action' do
    before do
      container.add_action :the_action do
         self.has_action?(:the_action)
      end
    end

    it { should have_action(:the_action) }
    it { should_not have_action(:another_action) }

    context 'when evaluating the action' do
      it 'evaluates the action within the context of the container' do
         result = container.eval_action(:the_action)
         result.should be_true
      end
    end

    context 'when safely evaluating the action' do
      it 'packages the result of the action in an array' do
        result = container.eval_action_safe(:the_action)
        result[0].should be_true
      end
    end
  end

  context "after adding an action 'search' that takes an argument" do
    before do
      container.add_action :search do |input|
        input
      end
    end

    describe "when evaluating the action with input 'meow'" do
      it 'calls the action and passes the argument to the block' do
        input = 'meow'
        result = container.eval_action(:search, input)
        result.should == input
      end
    end

    describe "when evaluating the action with no input" do
      it 'calls the action and passes nil as the argument to the block' do
        result = container.eval_action :search
        result.should be_nil
      end
    end

  end
  
  describe 'when safely evaluating an unknown action' do
    it 'does not raise an error but return nil' do
      result = container.eval_action_safe(:unknown_action)
      result.should be_nil
    end
  end

end
