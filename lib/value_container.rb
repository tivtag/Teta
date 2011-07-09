
module ValueContainer
  
  def initialize
    @values = {}
    super
  end

  def has_value?(key)
    @values.include? key
  end

  def has_no_value?(key)
    not has_value?(key)
  end

  def set(key, value = true)
    @values[key] = value
  end

  def unset(key)
    @values.delete key
  end

  def get(key)
    @values[key]
  end

  # DSL
  alias :itis :has_value?
  alias :itisnt :has_no_value?
end

