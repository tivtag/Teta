
module ActionContainer

  def initialize  
    @actions = {}
    super
  end

  def add_action(symbol, &block)
    @actions[symbol] = block
  end

  def has_action?(symbol)
    @actions.has_key? symbol
  end

  def eval_action(symbol, *args)
    action = @actions[symbol]

    self.instance_exec(*args, &action)
  end

  def eval_action_safe(symbol, *args)
     if has_action? symbol then
       [eval_action(symbol, *args)]
     else
       nil
     end
  end

end
