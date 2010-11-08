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
    @items.delete_at @items.find_index {|item| item.name == name}
  end

  def remove_items(names = nil)

     if names == nil then
        removed_items = @items.clone
        @items.clear
     else
        removed_items = []
        names.each do |name|
          item = remove_item(name)
          removed_items << item unless item == nil
        end
     end

     removed_items
  end
end
