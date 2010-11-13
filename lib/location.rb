require_relative 'item_container'
require_relative 'action_container'
require_relative 'value_container'
require_relative 'game_context_provider'

class Location
  include ItemContainer
  include ActionContainer
  include ValueContainer
  include GameContextProvider
  attr_accessor :name, :long_name, :description, :parent_location, 
                :child_locations, :remote_locations

  def initialize
    @child_locations = []
    @remote_locations = []
    super
  end

  def connected_locations
    locations = []    
    locations << parent_location unless parent_location == nil
    locations |= child_locations
    locations |= remote_locations
  end
  def connected_location_names
    connected_locations.map {|location| location.name}
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

  def connected?(location)
    connected_locations.include? location
  end

  def to_s
    "|#{name}, #{description} Parent = {#{if parent_location.nil? then "none" else parent_location.name end}}|\n"
  end

  def remove_last_sentence
    sentences = @description.scan /.*?[.!?](?:\s|$)/
    
    if sentences.length > 1 then
      @description = sentences[0..sentences.length - 2].join
    end
  end

  def take(symbol = :all)
     symbol = symbol.intern

     if symbol == :all then
       items = remove_items()
       player.add_items(items)
     else
       item = remove_item(symbol)
       
       if item != nil then
         player.add_item(item)
         puts "You find '#{item.long_name}'."
         item
       else
         nil
       end
     end
  end 
end
