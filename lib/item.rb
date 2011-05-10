
class Item
  attr_reader :name
  attr_accessor :long_name, :description

  def name=(symbol)
    @name = symbol
    @long_name ||= symbol.to_s.gsub(/_/, ' ')
  end

  # DSL hooks:

  def desc(text)
    @description = text
  end
end
