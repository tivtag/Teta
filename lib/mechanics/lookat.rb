
module Mechanics
  module LookAt

    def lookat(name)
      if name then
        if not (lookat_poi name or lookat_item name) then
          puts 'Nothing to look at.'
        end
      else
        print_location
      end
    end

    private
    def lookat_item(name)
      item = player.find_item_named_like name

      if item then
        if item.description then
          puts item.description
        else
          puts 'There is nothing special about this item.'
        end
        item
      else
        nil
      end
    end

    def lookat_poi(name)
      poi = @location.find_poi_named_like name

      if poi then
        if poi.description then
          puts poi.description
        end
        poi
      else
        nil
      end
    end

  end
end
