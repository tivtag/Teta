require_relative '../../lib/item_container'
require_relative '../../lib/item_factory'

shared_examples_for 'an ItemContainer' do
  
  let(:container) { described_class.new() }
  let(:factory) { ItemFactory.new }

  context 'when initialized' do
    it 'contains no items' do
      container.items.should have(0).items
    end
   
    it 'does not contain a specific Item' do
      container.has_item?(:potion).should be_false
    end   
 
    context 'after adding one Item' do
      let(:potion) { factory.create(:potion) }

      before do
        container.add_item potion
      end

      it 'contains the added Item' do
        container.has_item?(:potion).should be_true
      end

      it "does not contain an Item that wasn't added" do
        container.has_item?(:water).should be_false
      end

      it "can find the Item by any text that the name of the Item starts with" do
        names = [:p, :po, :pot, :poti, :potio, :potion]
        names.should be_all { |name|
          item = container.find_item_named_like name
          item == potion
        }
      end

      it "won't find any Item when searching for an unknown name" do
        names = [:tion, :b, :dot, :oti, :candle, :tree]
        names.should be_all { |name|
          item = container.find_item_named_like name
          item.nil?
        }
      end

      context 'and removing the Item again' do
        before do
          @item = container.remove_item :potion
        end

        it 'does not contain the Item anymore' do
          container.has_item?(:potion).should be_false
        end

        it 'returned the removed Item' do
          @item.name.should == :potion
        end
      end
 
    end

    context 'after adding multiple Items' do
      let(:item_names) { [:bag, :coin, :sweets, :coffee] }

      before do
        items = factory.create_all(item_names)
        container.add_items(items)
      end

      it 'contains all Items that were added' do
        container.has_items?(item_names).should be_true
      end

      it 'does not contain Items that were not added' do
        container.has_items?(item_names << :hat).should be_false
      end

      it 'will find the first occurrence when searching by similiarty' do
        item = container.find_item_named_like 'co'
        item.name.should == :coin
      end

      context 'after removing all Items' do
        before do
          @items = container.remove_items()
        end

        it 'does not contain any Items anymore' do
          container.items.length.should == 0
        end

        it 'returned the removed Items' do
          removed_item_names = @items.map {|item| item.name}
          removed_item_names.should == item_names
        end
      end

      context 'after removing a few of the Items' do
        let(:items_to_remove) { [:bag, :coin] }

        before do
          @items = container.remove_items(items_to_remove)
        end
  
        it 'does not contain the removed Items anymore' do
          container.has_items?(items_to_remove).should be_false
        end

        it 'still contains the other Items.' do
          container.has_item?(:sweets).should be_true
        end

        it 'returned the removed Items' do
          removed_item_names = @items.map {|item| item.name}
          removed_item_names.should == items_to_remove
        end
      end
    end

    context 'when trying to remove an unknown Item' do
      it 'should return nil' do
        item = container.remove_item(:blub)
        item.should be_nil
      end
    end
  end

end
