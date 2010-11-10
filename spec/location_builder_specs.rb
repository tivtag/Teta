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
    its(:child_locations) { should be_empty }
    its(:connected_locations) { should be_empty }

    it { should_not have_action(:any) } 
         
    it 'still returns only a single Location' do
      locations.length.should == 1
    end
  end
 
  describe 'when parsing hierarchical Locations' do
    let(:data) do
      lambda do

        location :street do
          location :park do
            location :bank do
            end
          end

          location :house do
            location :door do
            end
          end
        end

      end
    end

    let(:locations) { parse(data) }

    it 'returns the correct number of Locations' do
      locations.length.should == 5
    end

    it 'returns the described Locations' do
      names = locations.map {|location| location.name}
      names.should include(:street, :park, :bank, :house, :door)
    end

    it 'return Locations that are correctly connected to their parent Location' do
       parent_hash = {:street => nil, :park => :street, :bank => :park, :house => :street, :door => :house}
      
       locations.each {|location| location.should satisfy {|arg| parent_hash[location.name] == location.parent_location_name}}              
    end

    it 'returns Locations that know their child Locations' do
      hash = {
        :street => [:park, :house],
        :park => [:bank],
        :bank => [],
        :house => [:door],
        :door => []
      }

      locations.each do |location|
        child_location_names = location.child_locations.map {|location| location.name }
        child_location_names.should == hash[location.name]
      end
    end

    it 'returns Locations that are connected to their parent Location and child Locations' do
      hash = {
        :street => [:park, :house],
        :park => [:street, :bank],
        :bank => [:park],
        :house => [:street, :door],
        :door => [:house]
      }

      locations.each do |location|
        location_names = location.connected_locations.map {|location| location.name }
        location_names.should == hash[location.name]
      end
    end
  end
  
  describe 'when parsing a Location that includes an Item' do
    let(:data) do
      lambda do
        
        location :table do
          item :coin

          action :search do
            take :coin
          end
        end

      end
    end

    let(:loc) { parse(data).first }

    it 'returns a Location that has one Item' do
      loc.items.length == 1
    end

    context "then the Item's" do
      subject { loc.items[0] }

      its(:name) { should == :coin }
    end

  end
end
