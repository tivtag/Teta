require_relative 'location'
require_relative 'action_container'
require_relative 'game_context'
require_relative 'string_ext'

class Runner < GameContext
  include ActionContainer

  attr_accessor :locations, :location

  def initialize
    super
    @player = Player.new
    @running = true
    
    add_action :quit do
      @running = false
    end

    add_action :help do |cmd|

      if cmd == nil then
        puts 'Command List: '
        puts 'quit        - Quits this game.'
        puts 'goto [name] - Moves to the location that has the given [name].'
        puts 'inv         - Shows the content of your inventory.'
        puts 'use [obj]   - Uses an object in the current location or your inventory.'
        puts 'help [cmd]  - Shows extended help about the given [command].'
      else
        case cmd
        when 'quit'
          puts 'Quits this game. Progress is NOT saved. /sad'
        when 'goto'
          puts 'Moves to the location with the given [name]. The name does not have to be fully entered.'
          puts 'The following commands all would go to the kitchen (if only the kitchen was available):'
          puts 
          puts '    "goto kitchen"'
          puts '    "goto kit"'
          puts '    "goto k"'
          puts
          puts 'The list of available locations is shown if no location is entered.'
          puts ' Example usage: "goto"'
        when 'inv'
          puts 'Shows the content of your inventory.'
          puts 'You can use the [lookat] command to look at an item in your inventory.'
          puts '  Example usage: "lookat bottle"'
        when 'help'
          puts 'Meow?'
        when 'use'
          puts 'Uses an item in your inventory at the current location or uses an object at the current location.'
          puts '  Example usage: "use bottle"'
        else
          puts "Sorry. I can't help you."
        end
      end
    end

    add_action :inv do
      if player.items.length > 0 then
        @player.items.each do |item|
          puts "1x #{item.long_name}"
        end
      else
        puts '~ empty ~'
      end
    end

    add_action :goto do |location_name|
      available_locations = location.connected_locations

      if location_name != nil then
        loc = available_locations.find {|child| child.name == location_name.intern}

        # Allow the user to enter 'fi' to go to 'fire':
        if loc == nil then
          loc = available_locations.find {|child| child.name.to_s.start_set.include? location_name.to_s } 
        end
      else
        loc = nil
      end

      if loc != nil then
        change_location loc
        print_location
      else
        puts "I can't go there." unless location_name == nil
        available_locations.each {|loc| puts "    #{loc.name}"}        
      end
    end

    add_action :lookat do |item_name|
    
      if item_name != nil then
        item = player.find_item item_name

        if item != nil then
          if item.description != nil then
            puts item.description
          else
            puts 'There is nothing special about this item.'
          end
        else
          puts 'Nothing to look at.'
        end

      else
        print_location
      end

    end
  end

  def run
    setup_location
    print_location 
 
    while @running do
      step
    end
   
  end

private
  def step
      handle read_input
  end

  def read_input
     print '> '
     gets.chomp    
  end

  def handle(input)
    entries = input.split ' '
    action = entries.first.intern
    args   = entries[1..entries.length]
   
    if not handle_action(action, args) then
      puts "Huh..?"
    end
  end

  def handle_action(action, args)
    location.eval_action_safe(action, *args) or self.eval_action_safe(action, *args)
  end

  def print_location   
    text = @location.description.gsub(/\n/, '').gsub(/ +/, ' ')
    puts text
  end

  def change_location(loc)
    @location = loc
    setup_location
  end

  def setup_location
    @location.context = self
  end

end
