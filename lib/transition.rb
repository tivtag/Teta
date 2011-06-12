require_relative 'game_context_provider'
require_relative 'value_container'

class Transition
  include ValueContainer
  include GameContextProvider

  attr_accessor :a, :b
  attr_accessor :allowed
  attr_accessor :text 
  
  def initialize
    @walk_events = []
    
    @allowed = true
    @walk_count = 0
    super
  end

  def has_node?(node)
    a.to_sym == node.to_sym || b.to_sym == node.to_sym
  end

  def is_allowed?(from, to)
    self.allowed and from.allows_leave and to.allows_entry
  end

  def context
    @to.context
  end

  def walk(from, to)
    notify

    @walk_events.each {|e| self.instance_exec(from, to, &e) }
  end

  def notify
    @walk_count = @walk_count + 1
  end

  # DSL hooks
  def blocked
    @allowed = false
  end
  alias :block :blocked

  def desc(value)
    @text = value
  end
  
  def on_walk(&block)
    @walk_events << block
  end
end

