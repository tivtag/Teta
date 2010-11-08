require 'json'
require_relative 'item_container'
require_relative 'action_container'
require_relative 'game_context'

class Location
  include ItemContainer
  include ActionContainer
  include GameContext
  attr_accessor :name, :long_name, :description, :parent_location

  def initialize
    super
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

  def take(symbol = :all)
     if symbol == :all then
     else
     end
  end 
end
