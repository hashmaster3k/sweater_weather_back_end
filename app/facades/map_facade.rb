class MapFacade
  def self.coordinates_for_location(location)
    response = MapService.geocoding_address(location)
    Coordinate.new(response)
  end
end
