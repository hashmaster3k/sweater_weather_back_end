class TrailFacade
  def self.trails_near_location(location)
    coordinates = MapFacade.coordinates_for_location(location)
    weather = WeatherFacade.weather_for_location(coordinates.latitude, coordinates.longitude)
    results = TrailService.trails_by_location(coordinates.latitude, coordinates.longitude)
    Trail.new(results, weather, location, coordinates)
  end
end
