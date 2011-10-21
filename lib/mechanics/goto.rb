
module Mechanics
  module Goto

    def goto(location_name)
      loc = location.find_connected(location_name)

      if loc then
        change_location loc
      else
        puts "I can't go there." unless location_name == nil
        location.connected_locations.each {|l| puts "    #{l.name}"}        
      end
    end

    def go(dir)
      case dir
      when 'back', 'b'
        if @previous_location && @location.connected?(@previous_location) then
          change_location @previous_location
        else
          puts 'This is impossible!' 
        end
      else
        puts "I can't do that."
      end
    end

  end
end

