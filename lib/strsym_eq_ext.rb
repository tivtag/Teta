
class String
  
  alias :old_eq ==
  def ==(other)
    old_eq (if other then other.to_s else nil end)
  end

end

class Symbol
  
  alias :old_eq ==
  def ==(other)
    old_eq (if other.class == String then other.intern else other end)
  end

end
