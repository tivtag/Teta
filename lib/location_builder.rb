require_relative 'location'
require_relative 'item_factory'

module LocationBuilder

  @@locations = []
  @@obj_stack = []
  @@item_factory = ItemFactory.new

  def current_obj
    @@obj_stack.last
  end

  def location(sym)
    location = Location.new
    location.name = sym
    location.long_name = sym.to_s
    location.parent_location = current_obj

    @@locations << location
    @@obj_stack.push location  

    yield

    @@obj_stack.pop
  end

  def name(text)
    current_obj.long_name = text
  end

  def desc(text)
    current_obj.description = text
  end

  def remote_location(sym)
  end

  def item(name)
    current_obj.add_item @@item_factory.create(name) 
  end

  def action(symbol, &block)
    current_obj.add_action(symbol, &block)
  end

  def parse_file(fileName)
    load fileName
    finish_parse 
  end
  
  def parse(block)
    block.call
    finish_parse
  end
 
  def finish_parse
    locations = @@locations.clone
    @@locations.clear
    locations
  end

end
