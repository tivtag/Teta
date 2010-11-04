require_relative 'location'

class Runner
  
  attr_accessor :locations, :location

  def run
  
    while step do
    end
   
  end

private
  def step
      print_step
      handle read_input
  end

  def read_input
     print '> '
     gets.chomp    
  end

  def handle(input)
    if input == 'quit' then
       false
     else
       action = input.intern
       if location.has_action action then
         location.eval_action action
       else
         puts "I can't do that here."
       end
       true
     end
  end

  def print_step   
    text = location.description.gsub(/\n/, '').gsub(/ +/, ' ')
    puts text
  end

end
