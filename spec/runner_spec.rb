
require_relative '../lib/runner'

describe Runner do

  subject { Runner.new }
  
  describe 'User Actions' do
    it { should have_action(:l) }
    it { should have_action(:look) }
    it { should have_action(:lookat) }
    it { should have_action(:g) }
    it { should have_action(:go) }
    it { should have_action(:goto) }
    it { should have_action(:i) }
    it { should have_action(:inv) }
    it { should have_action(:q) }
    it { should have_action(:quit) }
    it { should have_action(:exit) }
    it { should have_action(:cls) }
    it { should have_action(:help) }

    if Runner::DEBUG then
      it { should have_action(:music) }
      it { should have_action(:changechapter) }
    else
      it { should_not have_action(:music) }
      it { should_not have_action(:changechapter) }
    end
  end
  
end
