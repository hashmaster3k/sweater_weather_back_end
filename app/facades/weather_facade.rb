class WeatherFacade
  def self.weather_for_location(lat, long)
    result = WeatherService.onecall_weather(lat, long)
    Forecast.new(result)
  end

  def self.hourly_forecast(lat, long)
    results = WeatherService.onecall_weather(lat, long)
    HourlyWeather.create_list(results[:hourly])
  end
end
