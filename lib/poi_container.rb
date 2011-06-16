
#
# PoI = Point of Interest
#
module PoiContainer
  attr_reader :pois

  def initialize
    @pois = []
    super
  end

  def add_poi(poi)
    @pois << poi
  end

  def find_poi_named_like(text)
    @pois.find {|poi| poi.name.to_s.start_with_any? text }
  end

end

