
class String

  def start_with_any?(text)
    start_set.include? text.to_s
  end

  def start_set
    entries = []
    
    0.upto(self.length - 1) do |i|
      entries << self[0..i]
    end   

    entries
  end

  alias :old_eq ==
  def ==(other)
    old_eq (if other then other.to_s else nil end)
  end
end

