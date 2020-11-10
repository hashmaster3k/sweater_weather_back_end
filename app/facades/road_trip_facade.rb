class RoadTripFacade
  def self.trip_details(origin, destination)
    travel_time = MapFacade.travel_time_between_two_locations(origin, destination)
    coordinates = MapFacade.coordinates_for_location(destination)
    weather_data = WeatherFacade.hourly_forecast(coordinates.latitude, coordinates.longitude)
    weather = weather_data[travel_time.second]
    RoadTrip.new(origin, destination, travel_time.first, weather)
  end
end
