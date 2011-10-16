
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
  
  def preparse
    self.gsub! /^look at/, 'look'
    self.gsub! /^examine/, 'look'
    self
  end

end

