require_relative '../lib/transition.rb'
require 'shared/value_container'

describe Transition do
  it_behaves_like 'a ValueContainer'
  
  let(:tran) { Transition.new }
  subject { tran }

  context 'when first created' do
    its(:allowed) { should be_true }
    its(:text)    { should be_nil }
    its(:a)    { should be_nil }
    its(:b)      { should be_nil }
  end

  describe 'Domain Specific Language' do

    context 'when blocked' do
      before do
        tran.blocked() 
      end

      its(:allowed) { should be_false }
      its(:text)    { should be_nil }
    end

    context 'when text is set' do
      before do
        tran.desc 'my text' 
      end

      its(:text) { should == 'my text' }
    end

  end
end

