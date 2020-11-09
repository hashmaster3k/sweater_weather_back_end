class HourlyWeather
  attr_reader :time,
              :predicted_temp,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon

  def self.create_list(data)
    data.map { |hour| new(hour) }
  end

  def initialize(hour)
    @time = Time.zone.at(hour[:dt]).strftime('%H:%M:%S')
    @predicted_temp = hour[:temp]
    @wind_speed = "#{hour[:wind_speed]} mph"
    @wind_direction = "from #{wind_dir(hour[:wind_deg])}"
    @conditions = hour[:weather].first[:description]
    @icon = hour[:weather].first[:icon]
  end

  def wind_dir(degree)
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
