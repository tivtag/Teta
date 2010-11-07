
shared_examples_for 'an ItemContainer' do
  
  let(:container) { described_class.new() }

  context 'when initialized' do
    it 'contains no items' do
      container.items.should have(0).items
    end
   
    it 'does not contain a specific Item' do
      container.has_item?(:potion).should be_false
    end   
 
    context 'after adding one Item' do

      before do
        container.add_item :potion
      end

      it 'contains the added Item' do
        container.has_item?(:potion).should be_true
      end

      it "does not contain an Item that wasn't added" do
        container.has_item?(:water).should be_false
      end
       
      context 'and removing the Item again' do
        before do
          container.remove_item :potion
        end

        it 'does not contain the Item anymore' do
          container.has_item?(:potion).should be_false
        end
      end
 
    end

    context 'after adding multiple Items' do
      let(:item_names) { [:bag, :coin, :sweets] }

      before do
        container.add_items(item_names)
      end

      it 'contains all Items that were added' do
        container.has_items?(item_names).should be_true
      end

      it 'but does not contain Items that were not added' do
        container.has_items?(item_names << :hat).should be_false
      end
    end
  end

end
