class Forecast
  attr_reader :id, :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    @id = nil
    @current_weather = CurrentWeather.new(data[:current])
    @daily_weather = DailyWeather.create_list(data[:daily][0..4])
    @hourly_weather = HourlyWeather.create_list(data[:hourly][0..7])
  end
end
