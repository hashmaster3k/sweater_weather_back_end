class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(day)
    @date = Time.zone.at(day[:dt]).strftime('%Y-%m-%d')
    @sunrise = Time.zone.at(day[:sunrise])
    @sunset = Time.zone.at(day[:sunset])
    @max_temp = day[:temp][:max]
    @min_temp = day[:temp][:min]
    @conditions = day[:weather].first[:description]
    @icon = day[:weather].first[:icon]
  end

  def self.create_list(data)
    data.map { |day| new(day) }
  end
end
