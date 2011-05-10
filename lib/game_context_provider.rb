require_relative 'game_context'
require_relative 'music_box'
require_relative 'dsl/choices'
require_relative 'dsl/items'

module GameContextProvider
  include DSL::Choices
  include DSL::Items

  attr_accessor :context

  def player
    context.player
  end

  # 
  # DSL hooks:
  #

  def unknown
    puts 'Huh..?'
  end

  def read_input
    context.read_input
  end

  def println(text)
    context.print_text text
  end

  def music(name)
     MusicBox.play name
  end
  
  
  def change_to_chapter(index)
    context.change_to_chapter index
  end
  
  def die
    context.die
  end
   
end
