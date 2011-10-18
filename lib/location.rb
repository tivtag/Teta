require_relative 'game_object'
require_relative 'transition_node'
require_relative 'item_container'
require_relative 'action_container'
require_relative 'value_container'
require_relative 'transition_container'
require_relative 'poi_container'
require_relative 'game_context_provider'
require_relative 'string_ext'

class Location < GameObject
  include GameContextProvider
  include ItemContainer
  include ActionContainer
  include ValueContainer
  include PoiContainer
  include TransitionContainer
  include TransitionNode

  attr_accessor :parent_location, :child_locations, :remote_locations

  def initialize
    @child_locations = []
    @remote_locations = []

    super
  end

  def connected_locations
    locations = []    
    if parent_location != nil then
      locations << parent_location if parent_location.allows_transition_from? self
    end

    locations += child_locations.find_all {|l| l.allows_transition_from? self}
    locations += remote_locations.find_all {|l| l.allows_transition_from? self}
    locations
  end

  def unlock_location(named)
    location = child_locations.find {|x| x.name == named }
    if location.nil? then
      raise "Could not find location '#{named}'."
    end

    location.unblock
  end

  def lock_location(named)
    location = child_locations.find {|x| x.name == named }
    location.block
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
  
  def connected?(location)
    connected_locations.include? location
  end

  def transition_to(location)
    return nil if location.nil?
    transition = self.find_allowed_transition_to location
    
    if transition then
      self.leave(location, transition) 
      transition.walk(self, location)
      location.enter(self, transition)
    end

    transition
  end

  def transition_from(location)
    if location.nil? then
      self.enter(nil, nil)
      true
    else
      location.transition_to self
    end
  end

  # Makes sure that all remote locations
  # are remotely connected to this location.
  def mirror_remote_locations
    remote_locations.each do |remote_location|
      remote_location.remote_locations.append_unique! self
    end
  end

  def to_s
    "|#{name} Parent = {#{if parent_location.nil? then "none" else parent_location.name end}}|\n"
  end

  # DSL hooks:
  def remove_last_sentence
    sentences = @description.scan(/.*?[.!?](?:\s|$)/)
    
    if sentences.length > 1 then
      @description = sentences[0..sentences.length - 2].join
    end
  end

  def take(symbol = :all)
     symbol = symbol.intern

     if symbol == :all then
       items = remove_items
       player.add_items(items)
     else
       item = remove_item symbol
       
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

