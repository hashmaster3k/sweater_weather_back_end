class WeatherFacade
  def self.weather_for_location(lat, long)
    result = WeatherService.onecall_weather(lat, long)
    Forecast.new(result)
  end
end
