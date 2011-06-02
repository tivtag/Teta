
require_relative '../../lib/game_object'

shared_examples_for 'a GameObject' do

  let(:obj) { described_class.new() }
  subject { obj }  

  context 'when first created' do
    its(:name)            { should be_nil }
    its(:description)     { should be_nil }
    its(:long_name)       { should be_nil }
  end

end
