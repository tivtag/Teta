require_relative 'transition'

module TransitionContainer
  attr_reader :transitions

  def initialize()
    @transitions = []
    
    super 
  end
  
  def add_transition(node)
    throw "Parameter 'node'(#{node.class}) must include TransitionNode" unless node.kind_of?(TransitionNode)

    t = find_transition node

    if t == nil then
      t = Transition.new()
      t.a = node
      t.b = self
    
      @transitions << t
      node.transitions << t
    end

    t
  end

  def disallow_transition()
    for_all_transitions do
      allowed = false
    end
  end

  def allow_transition()
    for_all_transitions do
      allowed = true
    end
  end

  def for_all_transitions(&block)
    @transitions.each {|t| t.instance_eval(&block) }
  end

  def allows_transition_from?(from)
    from ||= :any
    if from == :any || @transitions.length == 0 then
      return allows_entry 
    end

    t = find_transition from

    if t != nil then
      t.is_allowed?(from, self)
    else
      false
    end
  end

  def find_transition(node)
    if node.nil? then
       nil
    else
       @transitions.find {|t| t.has_node? node}
    end 
  end

end

