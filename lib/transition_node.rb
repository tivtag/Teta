
module TransitionNode
 
  attr_reader :allows_entry, :allows_leave

  def initialize
    @enter_events = []
    @leave_events = []

    @allows_entry = true
    @allows_leave = true
    super
  end

  def enter(from, over)
    @enter_events.each {|e| self.instance_exec(from, over, &e) }
  end

  def leave(to, over)
    @leave_events.each {|e| self.instance_exec(to, over, &e) }
  end

  # DSL:
  def on_enter(&block)
    @enter_events << block
  end
  
  def on_leave(&block)
    @leave_events << block
  end

  def blocked(dir = :entry)
    @allows_entry = false
  end

  def unblock(dir = :entry)
    @allows_entry = true
  end

  alias :block! :blocked
end

