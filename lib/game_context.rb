require_relative 'player'

module GameContext
  attr_accessor :player

  def setup_context(other_context)
    @player = other_context.player
  end
end
