class WeatherService
  def self.onecall_weather(lat, long)
    response = conn.get("#{ENV['WEATHER_URL']}onecall") do |req|
      req.params['lat'] = lat
      req.params['lon'] = long
      req.params['exclude'] = 'minutely,alerts'
      req.params['appid'] = ENV['WEATHER_API_KEY']
      req.params['units'] = 'imperial'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(
      url: ENV['WEATHER_URL'],
      headers: { 'Content-Type' => 'application/json' }
    )
  end
end
