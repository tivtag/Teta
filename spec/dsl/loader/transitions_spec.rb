require_relative '../../../lib/dsl/loader.rb'
require 'spec_helper'

include DSL::Loader
describe DSL::Loader, 'Transitions' do

  describe 'when parsing a Location that does not allow one to return' do
    let!(:data) do
      lambda do
        location :hell do
          blocked   
        end
      end
    end

    let!(:hell) { parse(data).first }

    it 'returns a Location that does not allow entry' do
      hell.allows_entry.should be_false
    end

    it 'returns a Location that allows leave' do
      hell.allows_leave.should be_true
    end

    it 'returns a Location with no transitions' do
      hell.transitions.should be_empty
    end

  end

  describe 'when parsing Locations which are partially blocked' do
    let(:data) do
      lambda do
        location :river do
          on_leave do
            blocked
          end

          location :sky do
            blocked
          end

          remote_location :boat do
            on_walk do
              set :river_to_boat
            end
          end
        end

        location :boat do
        end
      end
    end

    let(:locations) { parse(data) }
    let(:river)     { locations.first }
    let(:sky)       { locations.at(1) }
    let(:boat)      { locations.last }

    it 'allows entry to the river and boat' do
      river.allows_entry.should be_true
      boat.allows_entry.should be_true
    end

    it 'does not allow entry to the sky' do
      sky.allows_entry.should be_false
    end

    describe 'when transitioning from the :river to the :boat' do
      let!(:trans) { river.transition_to boat }

      it 'returned the used transition' do
        trans.should_not be_nil
      end

      it 'called the on_walk event on the transition' do
        trans.should have_value(:river_to_boat)
      end

      it 'called on_leave on the :river, disallowing entry to the river.' do
        river.allows_entry.should be_false
      end

      it 'did not change the entry allowance of the other locations' do
        boat.allows_entry.should be_true
        sky.allows_entry.should be_false
      end
    end

    describe 'when transitioning from the :river to the blocked :sky' do
      let!(:trans) { river.transition_to sky }

      it 'returned no transition to indicate that the path is blocked' do
        trans.should be_nil
      end

      it 'did not call on_leave on the :river' do
        river.allows_entry.should be_true
      end
    end

  end

  describe 'when parsing two remotely connected Locations that are setup to execute actions on entering/leaving' do
    let(:data) do
      lambda do

        location :street do
          on_enter do
            set :enter_street
          end
          on_leave do |to|
            set :left_to, to
          end

          remote_location :house do
            on_enter do |from|
              from.set :left
              set :entered
            end 
            
            on_leave do
              set :leave_house
            end
          end
        end

        location :house do
          on_enter do |from|
            from.set :left_2
            set :entered_2
          end
        end

      end
    end

    let(:locations) { parse(data) }
    let(:remote) { locations.last }
    let(:local) { locations.first }

    it 'created the location and the remote location' do
      (locations.map {|l| l.name}).should == [:street, :house]
    end

    it 'created a transition from the local location to the remote location' do
      local.find_transition(remote).should_not be_nil
    end

    it 'created a transition from the remote location to the local location' do
      remote.find_transition(local).should_not be_nil
    end

    describe 'when moving from the location to the remote location' do
      before do
        transition = local.transition_to remote
      end

      it 'called on_enter on the destination location' do
        local.should have_value(:left)
        remote.should have_value(:entered)
        local.should have_value(:left_2)
        remote.should have_value(:entered_2)
      end

      it 'passed the source location to the on_enter event of the destination location' do
        remote.should_not have_value(:left)
        local.should_not have_value(:entered)
        remote.should_not have_value(:left_2)
        local.should_not have_value(:entered_2)
      end

      it 'called on_leave on the source location' do
        local.get(:left_to).should == remote
      end
      
      it 'did not call on_enter on the source location' do
        local.should_not have_value(:leave_street)
      end

      it 'did not call on_leave on the destination location' do
        remote.should_not have_value(:leave_house)
      end
    end

  end

end

