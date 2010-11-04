require_relative 'item'

module ItemContainer

  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(name)
    item = Item.new
    item.name = name
    @items << item
    item  
  end
  
  def has_item?(name)
    find_item_by_name(name) != nil
  end

  def find_item_by_name(name)
     @items.find {|item| item.name == name}
  end

end
