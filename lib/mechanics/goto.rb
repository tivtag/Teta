
module Mechanics
  module Goto

    def goto(location_name)
      available_locations = location.connected_locations

      if location_name then
        loc = available_locations.find {|child| child.name == location_name.intern}

        # Allow the user to enter 'fi' to go to 'fire':
        if not loc then
          loc = available_locations.find {|child| child.name.to_s.start_set.include? location_name.to_s } 
        end
      else
        loc = nil
      end

      if loc then
        change_location loc
        
        puts
        print_location
      else
        puts "I can't go there." unless location_name == nil
        available_locations.each {|l| puts "    #{l.name}"}        
      end
    end

    def go(dir)
      case dir
      when 'back', 'b'
        if @previous_location && @location.connected?(@previous_location) then
          change_location @previous_location
          print_location
        else
          puts 'This is impossible!' 
        end
      else
        puts "I can't do that."
      end
    end

  end
end

