require_relative 'player'
require_relative 'item_factory'

class GameContext
  attr_accessor :player
  attr_reader :item_factory

  def initialize
    @item_factory = ItemFactory.new()
  end 

end
