require_relative '../lib/location_builder.rb'
include LocationBuilder

describe LocationBuilder do
 
  describe 'when parsing a single simple Location' do
    before do
      @locations = parse('spec/data/simple_location.rb')
      @location = @locations.first 
    end

    it 'returns a single Location' do
      @locations.length.should == 1
    end
    
    context 'returns a Location that has' do

      it 'the specified name' do
        @location.name.should == :town
      end

      it 'the specified long name' do
        @location.long_name.should == 'Viva La Vegas'
      end

      it 'the specified description' do
        @location.description.should == 'A great town.'
      end 

      it 'no actions' do
        @location.has_action(:any).should == false
      end

      it 'no parent Location' do
        @location.parent_location.should == nil
      end
    end

    it 'still returns only a single Location' do
      @locations.length.should == 1
    end
  end
  
  describe 'when parsing hierarchical Locations' do
    before do
      @locations = parse('spec/data/hierarchical_locations.rb')
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

  describe 'when parsing a Location that includes an Item' do
    before do
      @location = parse('spec/data/location_with_item.rb').first
    end
  
    context 'returns a single Location that' do
     
      it 'contains one Item' do
        @location.items.length == 1
      end
 
      it 'contains the described Item' do
        @location.items[0].name == :coin
      end
    end
  end

end
