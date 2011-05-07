require_relative 'game_context'
require_relative 'music_box'

module GameContextProvider
  attr_accessor :context

  def player
    @context.player
  end

  def remove_player(item, expected_item)
    item = item.intern

    if item == expected_item then
      player.remove_item item
    else
      nil
    end
  end

  def unknown
    puts 'Huh..?'
  end

  def music(name)
     MusicBox.play name
  end
  
end
