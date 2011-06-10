require_relative '../lib/help_system'
require 'spec_helper'

describe HelpSystem do

  let(:help) { HelpSystem.new }
  subject { help }

  it { should have_command(:all) }
  it { should have_command(:inv) }
  it { should have_command(:help) }
  it { should have_command(:goto) }
  it { should have_command(:go) }
  it { should have_command(:quit) }
  it { should have_command(:look) }
  it { should have_command(:use) }
  it { should have_command(:cls) }

end