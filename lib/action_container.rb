
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

  def eval_action(symbol)
    action = @actions[symbol]

    self.instance_eval(&action)
  end

  def eval_action_safe(symbol)
     if has_action? symbol then
       [eval_action(symbol)]
     else
       nil
     end
  end

end
