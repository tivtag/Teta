require_relative '../lib/location'
require_relative 'item_container_specs.rb'

describe Location do
  it_behaves_like 'an ItemContainer'

  describe "when first created" do
    
    before :each do
      @location = Location.new
    end
  
    it "has no name" do
      @location.name.should == nil
    end
  
    it "has no description" do
      @location.description.should == nil
    end

    it "has no long name" do
      @location.long_name.should == nil
    end

    it "has no parent location" do
      @location.parent_location.should == nil
    end

    it "does not know the name of the parent location" do
      @location.parent_location_name.should == nil
    end

    it "does not have any actions" do
      @location.has_action(:any).should == false
    end

    it "raises an error when evaluating any action" do
      lambda { @location.eval_action(:any) }.should raise_error
    end
  end
end

