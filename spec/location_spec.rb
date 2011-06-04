require_relative '../lib/location'
require 'shared/game_object'
require 'shared/item_container'
require 'shared/action_container'
require 'shared/game_context_provider'
require 'shared/value_container'
require 'shared/transition_node'
require 'spec_helper'

describe Location do
  it_behaves_like 'an ItemContainer'
  it_behaves_like 'an ActionContainer'
  it_behaves_like 'a GameContextProvider'
  it_behaves_like 'a ValueContainer'
  it_behaves_like 'a TransitionNode'
  it_behaves_like 'a GameObject'

  let(:location) { Location.new }
  subject { location }  

  context 'when first created' do
    its(:child_locations)     { should be_empty }
    its(:connected_locations) { should be_empty }
    
    it 'does not know the name of the parent location' do
      location.parent_location_name.should be_nil
    end

    it 'has no transition state' do
       location.transitions.should be_empty
    end

    it 'allows transition from :any location' do
      location.allows_transition_from?(:any).should be_true
    end

    it 'allows transition from nil location' do
      location.allows_transition_from?(nil).should be_true
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

