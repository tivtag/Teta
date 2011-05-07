
class Transition

  attr_accessor :from, :to
  attr_accessor :allowed
  attr_accessor :text 
  
  def initialize()
    @allowed = true
    @walk_count = 0
  end

  def notify()
    @walk_count = @walk_count + 1
  end

  # DSL hooks
  def blocked()
    @allowed = false
  end

  def desc(value)
    @text = value
  end

end
