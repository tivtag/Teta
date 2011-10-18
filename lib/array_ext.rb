class Array

  def append_unique!(item)
    if not include?(item) then
      self << item
    end

    self
  end

end
