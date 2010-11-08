require_relative 'item'

module ItemContainer

  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
    item  
  end

  def add_items(items)
    items.each do |item|
       add_item(item)
    end
    items
  end
  
  def has_item?(name)
    find_item_by_name(name) != nil
  end

  def has_items?(names)
    not names.find {|name| not has_item?(name) }
  end

  def find_item_by_name(name)
     @items.find {|item| item.name == name}
  end
  
  def remove_item(name)
    item = @items.delete_at @items.find_index {|item| item.name == name}
  end

end
