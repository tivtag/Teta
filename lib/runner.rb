require_relative 'location'
require_relative 'action_container'

class Runner
  includes ActionContainer

  attr_accessor :locations, :location

  def initialize
    @running = true
     
    add_action(:quit, { @running = false })
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
   
    if location.has_action? action then
      location.eval_action action
    else if self.has_action? action then
  
      

      puts "Huh..?"
    end
  end

  def handle_action(action)
      if location.has_action? action then
        location.eval_action action
        true
      else
              

        false
      end
  end

  def print_location   
    text = location.description.gsub(/\n/, '').gsub(/ +/, ' ')
    puts text
  end

end
