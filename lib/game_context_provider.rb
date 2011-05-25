require_relative 'game_context'
require_relative 'music_box'
require_relative 'dsl/choices'
require_relative 'dsl/items'

module GameContextProvider
  include DSL::Choices
  include DSL::Items

  attr_accessor :context
 
  def method_missing(name, *args)
    context.send(name, *args)
  end

  # DSL hooks:
  #

  def unknown
    puts 'Huh..?'
  end

  def println(text)
    context.print_text text
  end

  def music(name)
     MusicBox.play name
  end
   
end
