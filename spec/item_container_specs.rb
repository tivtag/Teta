
shared_examples_for 'an ItemContainer' do
  
  let(:container) { described_class.new() }
  
  context 'when initialized' do
    it 'contains no items' do
      container.items.should have(0).items
    end
  end

end
