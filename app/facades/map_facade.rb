class MapFacade
  def self.coordinates_for_location(location)
    result = MapService.geocoding_address(location)
    Coordinate.new(result)
  end

  def self.travel_time_between_two_locations(origin, destination)
    result = MapService.route(origin, destination)
    if result[:info][:statuscode] == 402
      time_string = 'impossible route'
      hours = 0
    else
      time_string = convert_to_readable_time(result[:route][:realTime])
      hours = total_hours(result[:route][:realTime])
    end
    [time_string, hours]
  end

  private_class_method def self.convert_to_readable_time(time_seconds)
    minutes = (time_seconds % 3_600) / 60
    hours = (time_seconds % 86_400) / 3_600
    days = (time_seconds % (86_400 * 30)) / 86_400
    if days.positive?
      "#{days} day #{hours} hr #{minutes} min"
    elsif hours.positive?
      "#{hours} hr #{minutes} min"
    else
      "#{minutes} min"
    end
  end

  private_class_method def self.total_hours(time_seconds)
    time_seconds / 3600
  end
end
