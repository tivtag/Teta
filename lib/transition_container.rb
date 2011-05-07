require_relative 'transition'

module TransitionContainer

  attr_reader :transitions

  def initialize()
    @transitions = []
    
    add_transition_from :any
    super 
  end

  def transition()
    @transitions.first
  end

  def add_transition_from(from)
    
    from = from || :any
    t = find_transition_from from

    if t == nil then
      t = Transition.new()
      t.from = from
      t.to = self
    
      @transitions << t
    end

    t
  end

  def allows_transition_from?(from)

    if !transition.allowed then
       return false
    end      

    if from == :any || @transitions.length == 1 then
      return true
    end

    t = find_transition_from from

    if t != nil then
      t.allowed
    else
      false
    end
  end

  def find_transition_from(from)
    @transitions.find {|t| t.from.to_sym  == from.to_sym } 
  end

end

