require 'json'

class Location
  attr_accessor :name, :long_name, :description, :parent_location

  def initialize()
    @actions = {}
  end

  def parent_location_name
     if parent_location.nil? then
       nil
     else
       parent_location.name
     end
  end

  def desc(text)
    @description = text
  end

  def to_s
    "|#{name}, #{description} Parent = {#{if parent_location.nil? then "none" else parent_location.name end}}|\n"
  end
  
  def add_action(symbol, &block)
    @actions[symbol] = block
  end

  def has_action(symbol)
    @actions.has_key? symbol
  end

  def eval_action(symbol)
    action = @actions[symbol]

    self.instance_eval(&action)
  end

  def take(symbol = :all)
     puts "Huh.."
  end 
end
