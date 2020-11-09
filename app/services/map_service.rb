class MapService
  def self.geocoding_address(location)
    response = Faraday.get("#{ENV['MAP_URL']}geocoding/v1/address?key=#{ENV['MAP_API_KEY']}&location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.distance_between_two_locations(lat1, long1, lat2,long2)
    response = Faraday.get("#{ENV['MAP_URL']}directions/v2/route?&from=#{lat1},#{long1}&key=#{ENV['MAP_API_KEY']}&to=#{lat2},#{long2}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
