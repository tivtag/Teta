
class CommandHistory
  include Enumerable

  MAXIMUM_SIZE = 10

  def initialize
    @stack = []
  end

  def size
    @stack.size
  end

  def add(command)
    if size == MAXIMUM_SIZE then
      pop_first
    end

    @stack.push command
  end

  def each(&blk)
     @stack.each(&blk)
  end

  private
  def pop_first
    @stack.delete_at 0 if size > 0
  end

end

