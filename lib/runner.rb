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
      puts 'quit - Quits the game.'
      puts 'inv  - Shows the content of your inventory.' 
      puts 'help - Shows this list:)'
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
    action = input.intern
   
    if not handle_action action then
      puts "Huh..?"
    end
  end

  def handle_action(action)
    location.eval_action_safe action or self.eval_action_safe action 
  end

  def print_location   
    text = location.description.gsub(/\n/, '').gsub(/ +/, ' ')
    puts text
  end

  def setup_location
    @location.setup_context(self)
  end

end
