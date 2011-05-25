
class HelpSystem
  
  def call(command)
    if not command or command.empty? then
      Commands.all
    else
      if has_command? command then
        Commands.send command
      else
        puts "Sorry! I can't help you."
      end
    end
  end

  def has_command?(name)
    Commands.methods.include? name.intern
  end

  class Commands
    class << self    
      def all
        puts 'Command List: '
        puts 'quit        - Quits this game.'
        puts 'goto [name] - Moves to the location that has the given [name].'
        puts 'go back     - Movies to the previous location.'
        puts 'inv         - Shows the content of your inventory.'
        puts 'use [obj]   - Uses an object in the current location or your inventory.'
        puts 'look [name] - Looks at the inventory object with the given [name].'
        puts 'cls         - Clears the screen of text.'
        puts 'help [cmd]  - Shows extended help about the given [command].'
      end

      def quit
        puts 'Quits this game. Progress is NOT saved. /sad'
      end

      def go
        puts 'Moves to the previous location if [back] or [b] is given.'
        puts '  Example usage: "go back"'
      end

      def goto
        puts 'Moves to the location with the given [name]. The name does not have to be fully entered.'
        puts 'The following commands all would go to the kitchen (if only the kitchen was available):'
        puts 
        puts '    "goto kitchen"'
        puts '    "goto kit"'
        puts '    "goto k"'
        puts
        puts 'The list of available locations is shown if no location is entered.'
        puts ' Example usage: "goto"'
      end

      def inv
        puts 'Shows the content of your inventory.'
        puts 'You can use the [look] command to look at an item in your inventory.'
        puts '  Example usage: "inv"'
      end

      def look
        puts 'Takes a closer look at the item with the given [name]. Supports partial names.'
        puts '  Example usage: "look bottle"'
      end

      def help      
        puts 'Meow?'
      end

      def use
        puts 'Uses an item in your inventory at the current location or uses an object at the current location.'
        puts '  Example usage: "use bottle"'
      end

      def cls
        puts 'Clears the screen from all text but the input prompt.'
        puts 'Use "lookat" to show the description of the current location.'
        puts '  Example usage: "cls"'
      end
    end
  end
end
