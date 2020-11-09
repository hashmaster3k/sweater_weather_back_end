class Trail
  attr_reader :id, :location, :forecast, :trails

  def initialize(trails, weather, location, coordinates)
    @id = nil
    @trails = trails_info(trails, coordinates)
    @forecast = weather_to_forecast(weather)
    @location = location
  end

  def trails_info(trails, coordinates)
    trails[:trails].map do |trail|
      {
        name: trail[:name],
        summary: trail[:summary],
        difficulty: trail[:difficulty],
        location: trail[:location],
        distance_to_trail: get_distance(coordinates.latitude,
                                        coordinates.longitude,
                                        trail[:latitude],
                                        trail[:longitude])
      }
    end
  end

  def get_distance(lat1, long1, lat2,long2)
    MapFacade.distance_between_two_locations(lat1, long1, lat2,long2)
  end

  def weather_to_forecast(weather)
    {
      summary: weather.current_weather[:conditions],
      temperature: weather.current_weather[:temperature]
    }
  end
end
