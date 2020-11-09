class TrailService
  def self.trails_by_location(lat, long)
    response = Faraday.get("#{ENV['TRAIL_URL']}/get-trails?lat=#{lat}&lon=#{long}&maxDistance=10&key=#{ENV['TRAIL_API_KEY']}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
