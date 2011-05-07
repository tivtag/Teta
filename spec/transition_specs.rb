require_relative '../lib/transition.rb'

describe Transition do

   let(:tran) { Transition.new }
   subject { tran }

   context 'when first created' do
      its(:allowed) { should be_true }
      its(:text)    { should be_nil }
      its(:from)    { should be_nil }
      its(:to)      { should be_nil }
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
