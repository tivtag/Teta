require_relative '../lib/item'

describe Item do

  context 'when initialized' do
     before do
        @item = Item.new
     end

     it 'has no name' do
        @item.name.should == nil
     end
    
     it 'has no long name' do
       @item.long_name.should == nil
     end

     context 'when name is set' do
         before do 
            @item.name = :red_coin
         end

         it 'has the specified name' do
           @item.name.should == :red_coin
         end
         
         it 'also sets the long name' do
           @item.long_name.should == 'red coin'
         end 
     end
  end

end
