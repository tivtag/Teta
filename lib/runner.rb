require_relative 'location'
require_relative 'action_container'

class Runner
  include ActionContainer

  attr_accessor :locations, :location

  def initialize
    super
    @running = true
     
    add_action :quit do
      @running = false
    end

    add_action :help do
      puts "Command List: "
      puts "quit - Quits the game."
      puts "help - Shows this list:)"
    end
  end

  def run
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

end
