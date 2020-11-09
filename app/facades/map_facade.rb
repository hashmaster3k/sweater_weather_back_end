class MapFacade
  def self.coordinates_for_location(location)
    response = MapService.geocoding_address(location)
    Coordinate.new(response)
  end

  def self.distance_between_two_locations(lat1, long1, lat2,long2)
    response = MapService.distance_between_two_locations(lat1, long1, lat2,long2)
    response[:route][:distance]
  end
end
