require 'rb-readline'

module RbReadline
  def self.rl_ding
    # Patch away that slightly annoying Terminal Bell.
  end
end

module Kernel
  alias :old_puts :puts

  def puts(dirty_text=nil)
    if dirty_text.nil? then
      old_puts
    else
      lines = dirty_text.
        split("\n").
        map {|line| line.strip }

      text = lines.join "\n"
      old_puts text
    end
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
    puts dirty_text
  end
end

