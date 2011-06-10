
module Mechanics
  module Goto

    def goto(location_name)
      available = location.connected_locations
      loc = find_location(location_name, available)

      if loc then
        change_location loc
        
        puts
        print_location
      else
        puts "I can't go there." unless location_name == nil
        available.each {|l| puts "    #{l.name}"}        
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

  private
    def find_location(name, available)
      if name then
        loc = available.find {|child| child.name == name.intern}

        # Allow the user to enter 'fi' to go to 'fire':
        if not loc then
          loc = available.find {|child| child.name.to_s.start_with_any? name } 
        end
      else
        loc = nil
      end

      loc
    end

  end
end

