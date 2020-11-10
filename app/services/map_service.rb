class MapService
  def self.geocoding_address(location)
    response = Faraday.get("#{ENV['MAP_URL']}geocoding/v1/address?key=#{ENV['MAP_API_KEY']}&location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.route(origin, destination)
    response = Faraday.get("#{ENV['MAP_URL']}directions/v2/route?key=#{ENV['MAP_API_KEY']}&from=#{origin}&to=#{destination}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
