class Forecast
  attr_reader :id, :current, :daily, :hourly

  def initialize(data)
    @id = nil
    @current = current_weather(data[:current])
    @daily = daily_weather(data[:daily])[0..4]
    @hourly = hourly_weather(data[:hourly][0..7])
  end

  def current_weather(current)
    { datetime: Time.zone.at(current[:dt]),
      sunrise: Time.zone.at(current[:sunrise]),
      sunset: Time.zone.at(current[:sunset]),
      temperature: current[:temp],
      feels_like: current[:feels_like],
      humidity: current[:humidity],
      uvi: current[:uvi],
      visibility: (current[:visibility] * 0.000621371).round(1),
      conditions: current[:weather].first[:description],
      icon: current[:weather].first[:icon] }
  end

  def daily_weather(daily)
    daily.map do |day|
      { date: Time.zone.at(day[:dt]).strftime('%Y-%m-%d'),
        sunrise: Time.zone.at(day[:sunrise]),
        sunset: Time.zone.at(day[:sunset]),
        max_temp: day[:temp][:max],
        min_temp: day[:temp][:min],
        conditions: day[:weather].first[:description],
        icon: day[:weather].first[:icon] }
    end
  end

  def hourly_weather(hours)
    hours.map do |hour|
      { time: Time.zone.at(hour[:dt]).strftime('%H:%M:%S'),
        wind_speed: "#{hour[:wind_speed]} mph",
        wind_direction: "from #{wind_direction(hour[:wind_deg])}",
        conditions: hour[:weather].first[:description],
        icon: hour[:weather].first[:icon] }
    end
  end

  def wind_direction(degree)
    return 'NE' if degree.between?(22.5, 67.5)
    return 'E' if degree.between?(67.5, 112.5)
    return 'SE' if degree.between?(112.5, 157.5)
    return 'S' if degree.between?(157.5, 202.5)
    return 'SW' if degree.between?(202.5, 247.5)
    return 'W' if degree.between?(247.5, 292.5)
    return 'NW' if degree.between?(292.5, 337.5)

    'N'
  end
end
