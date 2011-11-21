
module DSL
  module Items

  def has_player_item?(item)
    player.has_item? item
  end

  def remove_player(item, expected_item)
    if item == expected_item then
      player.remove_item item
    else
      nil
    end
  end

  def give_new_item(name, description=nil)
    item = context.item_factory.create(name)

    if description != nil then
      item.description = description
    end

    if block_given? then
      block = Proc.new
      item.instance_eval block
    end

    player.add_item item
  end

  end
end
