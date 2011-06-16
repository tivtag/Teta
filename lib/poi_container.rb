
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
end
