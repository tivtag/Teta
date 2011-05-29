require_relative '../lib/item'
require 'shared/game_object_specs'

describe Item do
  it_behaves_like 'a GameObject'
  
  context 'when initialized' do
    let(:item) { Item.new }
    subject { item }

    context 'when name is set to :red_coin' do
      before do 
        item.name = :red_coin
      end

      its(:name)        { should == :red_coin }
      its(:long_name)   { should == 'red coin' }
      its(:description) { should be_nil } 
    end
    
    context "when the description is set to 'Mew.'" do
      before do
        item.desc 'Mew.'
      end

      its(:description) { should == 'Mew.' }
    end

  end

end
