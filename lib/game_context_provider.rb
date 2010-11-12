require_relative 'game_context'

module GameContextProvider
  attr_accessor :context

  def player
    context.player
  end

  def remove_player_item(actual_item, expected_item)
    if actual_item == expected_item then
      player.remove_item actual_item
    else
      nil
    end
  end

  def unknown
    puts 'Huh..?'
  end

end
