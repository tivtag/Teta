require_relative '../lib/help_system'
require 'spec_helper'

describe HelpSystem do

  let(:help) { HelpSystem.new }
  subject { help }

  cmds = %w[all inv help goto go quit look use cls].
    map(&:to_sym)

  it 'should print the help overview when asking for help about no topic' do
      $stdout.should_receive(:puts).at_least(cmds.length).times
      help.call ''
  end

  it 'should print an excuse when asking for help about an unknown topic' do
      $stdout.should_receive(:puts).at_least(:once)
      help.call 'unknown'
  end

  cmds.each do|cmd|
    it { should have_command(cmd) }

    it "should print text when asking help about :#{cmd}" do
      $stdout.should_receive(:puts).at_least(:once)
      help.call cmd
    end
  end

end
