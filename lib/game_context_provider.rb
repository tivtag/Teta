require_relative 'game_context'

module GameContextProvider
  attr_accessor :context

  def player
    context.player
  end

end
