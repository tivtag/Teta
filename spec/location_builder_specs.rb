require_relative '../lib/location_builder.rb'
include LocationBuilder

describe LocationBuilder do
 
  describe 'when parsing a single simple Location' do
    before do
      @locations = parse('specs/data/simple_location.rb')
      @location = @locations.first 
    end

    it 'returns a single Location' do
      @locations.length.should == 1
    end

    it 'returns a Location that has the specified name' do
      @location.name.should == :town
    end

    it 'returns a Location that has the specified long name' do
      @location.long_name.should == 'Viva La Vegas'
    end

    it 'returns a Location that has the specified description' do
      @location.description.should == 'A great town.'
    end 

    it 'returns a Location with no actions' do
      @location.has_action(:any).should == false
    end

    it 'returns a Location with no parent Location' do
      @location.parent_location.should == nil
    end

    it 'still returns only a single Location' do
      @locations.length.should == 1
    end
  end
  
  describe 'when parsing hierarchical Locations' do
    before do
      @locations = parse('specs/data/hierarchical_locations.rb')
    end

    it 'returns the correct number of Locations' do
      @locations.length.should == 5
    end

    it 'returns the described Locations' do
      names = @locations.map {|location| location.name}
      names.should include(:street, :park, :bank, :house, :door)
    end

    it 'return Locations that are correctly connected to their parent Location' do
       parent_hash = {:street => nil, :park => :street, :bank => :park, :house => :street, :door => :house}
      
       @locations.each {|location| location.should satisfy {|arg| parent_hash[location.name] == location.parent_location_name}}              
    end
  end
end
