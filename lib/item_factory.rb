require_relative 'item'

class ItemFactory

  def create(name)
    item = Item.new
    item.name = name
    item
  end

  def create_all(names)
  
    items = []
    names.each do |name|
      items << create(name)
    end
    items

  end

end
