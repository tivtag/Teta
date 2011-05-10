require_relative 'game_context_provider'

class Transition
  include GameContextProvider

  attr_accessor :from, :to
  attr_accessor :allowed
  attr_accessor :text 
  
  def initialize()
    @allowed = true
    @walk_count = 0
  end

  def context()
    @to.context
  end

  def enter()
    notify

    if @entered != nil then
      self.instance_eval(&@entered)
    end
  end

  def leave()
    notify
  end

  def notify()
    @walk_count = @walk_count + 1
  end

  # DSL hooks
  def blocked()
    @allowed = false
  end
  alias :block :blocked

  def desc(value)
    @text = value
  end
  
  def on_enter(&block)
    @entered = block
  end
end
