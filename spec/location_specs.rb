require_relative '../lib/location'
require 'shared/item_container_specs'
require 'shared/action_container_specs'
require 'shared/game_context_provider_specs'
require 'shared/value_container_specs'

describe Location do
  it_behaves_like 'an ItemContainer'
  it_behaves_like 'an ActionContainer'
  it_behaves_like 'a GameContextProvider'
  it_behaves_like 'a ValueContainer'

  let(:location) { Location.new }
  subject { location }  

  context 'when first created' do
   
    its(:name)            { should be_nil }
    its(:description)     { should be_nil }
    its(:long_name)       { should be_nil }

    its(:child_locations)     { should be_empty }
    its(:connected_locations) { should be_empty }
    
    it 'does not know the name of the parent location' do
      location.parent_location_name.should == nil
    end

  end

  context 'when the parent location is set' do
    before do
      @parent_location = Location.new
      @parent_location.name = :parent

      location.parent_location = @parent_location
    end

    its(:parent_location) { should == @parent_location }

    it 'knows the name of the parent location' do
      location.parent_location_name.should == :parent
    end
   
    it 'should contain the parent location in the list of locations it is connected to' do
      location.connected_locations.should include(@parent_location)
    end
  end

end

