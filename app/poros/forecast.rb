class Forecast
  attr_reader :id, :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    @id = nil
    @current_weather = current_data(data[:current])
    @daily_weather = daily_data(data[:daily])[0..4]
    @hourly_weather = hourly_data(data[:hourly][0..7])
  end

  def current_data(data)
    { datetime: Time.zone.at(data[:dt]),
      sunrise: Time.zone.at(data[:sunrise]),
      sunset: Time.zone.at(data[:sunset]),
      temperature: data[:temp],
      feels_like: data[:feels_like],
      humidity: data[:humidity],
      uvi: data[:uvi],
      visibility: (data[:visibility] * 0.000621371).round(1),
      conditions: data[:weather].first[:description],
      icon: data[:weather].first[:icon] }
  end

  def daily_data(data)
    data.map do |day|
      { date: Time.zone.at(day[:dt]).strftime('%Y-%m-%d'),
        sunrise: Time.zone.at(day[:sunrise]),
        sunset: Time.zone.at(day[:sunset]),
        max_temp: day[:temp][:max],
        min_temp: day[:temp][:min],
        conditions: day[:weather].first[:description],
        icon: day[:weather].first[:icon] }
    end
  end

  def hourly_data(data)
    data.map do |hour|
      { time: Time.zone.at(hour[:dt]).strftime('%H:%M:%S'),
        temp: hour[:temp],
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
