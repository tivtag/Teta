require_relative '../lib/item'

describe Item do

  context 'when initialized' do
     before do
        @item = Item.new
     end

     it 'has no name' do
        @item.name.should == nil
     end

     context 'when name is set' do
         before do 
            @item.name = :coin
         end

         it 'has the specified name' do
           @item.name.should == :coin
         end
     end
  end

end
