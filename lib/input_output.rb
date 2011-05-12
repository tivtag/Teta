require 'rb-readline'

module RbReadline
  def self.rl_ding
    # Patch away that slightly annoying Terminal Bell.
  end
end

module InputOutput
  def read_input
    begin
      Readline.readline('> ', true)
    rescue Interrupt
      @running = false
      ""
    end
  end

  def print_text(dirty_text)
    if not dirty_text.nil? then
      lines = dirty_text.split("\n").map {|line| line.strip }
      text = lines.join "\n"
    
      puts text
    end
  end
end

