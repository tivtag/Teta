require_relative '../lib/location'
require_relative 'item_container_specs.rb'

describe Location do
  it_behaves_like 'an ItemContainer'

  describe "when first created" do
    
    let(:location) { Location.new }
    subject { location }  
   
    its(:name)            { should be_nil }
    its(:description)     { should be_nil }
    its(:long_name)       { should be_nil }
    its(:parent_location) { should be_nil }   

    it { should_not have_action(:any) }
    
    it "does not know the name of the parent location" do
      location.parent_location_name.should == nil
    end

    it "raises an error when evaluating any action" do
      lambda { location.eval_action(:any) }.should raise_error
    end
  end
end

