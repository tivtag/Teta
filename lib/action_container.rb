
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

end
