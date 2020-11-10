class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(origin, destination, travel_time, weather_info)
    @id = nil
    @start_city = origin
    @end_city = destination
    @travel_time = travel_time
    @weather_at_eta = weather(weather_info)
  end

  def weather(weather_info)
    unless @travel_time == 'impossible route'
      {
        temperature: weather_info.predicted_temp,
        conditions: weather_info.conditions
      }
    end
  end
end
