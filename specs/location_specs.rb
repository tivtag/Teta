require_relative "../lib/location"

describe Location, "when first created" do

  before :each do
    @location = Location.new
  end
  
  it "should have no name" do
    @location.name.should == nil
  end
  
  it "should have no description" do
    @location.description.should == nil
  end

  it "should have no long name" do
    @location.long_name.should == nil
  end

  it "should have no parent location" do
    @location.parent_location.should == nil
  end

  it "should not have any actions" do
    @location.has_action(:any).should == false
  end

  it "should raise an error when evaluating any action" do
    lambda { @location.eval_action(:any) }.should raise_error
  end
end

