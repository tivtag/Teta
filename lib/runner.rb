require_relative 'location'

class Runner
  
  attr_accessor :locations, :location

  def run
    print_location 
 
    while step do
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

    if action == :quit then
       false
    else
      if location.has_action? action then
        location.eval_action action
      else
        puts "Huh..?"
      end
      true
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
