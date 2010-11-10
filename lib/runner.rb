require_relative 'location'
require_relative 'action_container'
require_relative 'game_context'

class Runner
  include ActionContainer
  include GameContext

  attr_accessor :locations, :location

  def initialize
    super
    @player = Player.new
    @running = true
    
    add_action :quit do
      @running = false
    end

    add_action :help do
      puts 'Command List: '
      puts 'quit        - Quits the game.'
      puts 'goto [name] - Moves to the location that has the given [name].'
      puts 'inv         - Shows the content of your inventory.' 
      puts 'help        - Shows this list:)'
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
      else
        loc = nil
      end

      if loc != nil then
        change_location loc
        print_location
      else
        puts "I can't go there." unless location_name == nil
        puts 'Available: '
        available_locations.each {|loc| puts "  #{loc.name}"}        
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
    @location.setup_context(self)
  end

end
