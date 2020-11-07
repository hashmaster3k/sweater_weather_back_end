class WeatherService
  def self.onecall_weather(lat, long)
    response = Faraday.get("#{ENV['WEATHER_URL']}onecall?lat=#{lat}&lon=#{long}&exclude=minutely,alerts&appid=#{ENV['WEATHER_API_KEY']}&units=imperial")
    JSON.parse(response.body, symbolize_names: true)
  end
end
