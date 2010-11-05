require_relative '../lib/location_builder.rb'
include LocationBuilder

describe LocationBuilder do
 
  describe 'when parsing a single simple Location' do
     
    let(:data) do
       lambda do
          location :town do
            name 'Viva La Vegas'
            desc 'A great town.'
         end 
       end
    end

    let(:locations) { parse(data) }
    subject { locations.first }
 
    it 'returns a single Location' do
      locations.length.should == 1
    end
    
    its(:name)            { should == :town }
    its(:long_name)       { should == 'Viva La Vegas' }
    its(:description)     { should == 'A great town.' }
    its(:parent_location) { should be_nil }

    it { should_not have_action(:any) } 

    it 'still returns only a single Location' do
      locations.length.should == 1
    end
  end
  
  describe 'when parsing hierarchical Locations' do
    before do
      @locations = parse_file('spec/data/hierarchical_locations.rb')
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
      @location = parse_file('spec/data/location_with_item.rb').first
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
