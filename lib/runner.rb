require_relative 'location'
require_relative 'help_system'
require_relative 'action_container'
require_relative 'game_context'
require_relative 'string_ext'

class Runner < GameContext
  include ActionContainer

  attr_reader :previous_location
  attr_accessor :locations, :location

  def initialize
    super
  
    @player  = Player.new
    @help    = HelpSystem.new
    @running = true

    add_action :quit do
      @running = false
    end

    add_action :help do |cmd|
      @help.call cmd
    end
    
    add_action :go do |dir|

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
        print_location
      else
        puts "I can't go there." unless location_name == nil
        available_locations.each {|loc| puts "    #{loc.name}"}        
      end
    end

    add_action :look do |item_name|
    
      if item_name then
        item = player.find_item_named_like item_name

        if item then
          if item.description then
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
    @previous_location = @location
    @location = loc
    setup_location
  end

  def setup_location
    @location.context = self
  end

end
