require_relative '../lib/location'
require 'shared/item_container_specs'
require 'shared/action_container_specs'

describe Location do
  it_behaves_like 'an ItemContainer'
  it_behaves_like 'an ActionContainer'

  describe "when first created" do
    
    let(:location) { Location.new }
    subject { location }  
   
    its(:name)            { should be_nil }
    its(:description)     { should be_nil }
    its(:long_name)       { should be_nil }
    its(:parent_location) { should be_nil }   
    
    it "does not know the name of the parent location" do
      location.parent_location_name.should == nil
    end

  end
end

