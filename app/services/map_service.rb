class MapService
  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.geocoding_address(location)
    response = conn.get("#{ENV['MAP_URL']}geocoding/v1/address") do |req|
      req.params['key'] = ENV['MAP_API_KEY']
      req.params['location'] = location
    end
    parse(response)
  end

  def self.route(origin, destination)
    response = conn.get("#{ENV['MAP_URL']}directions/v2/route") do |req|
      req.params['key'] = ENV['MAP_API_KEY']
      req.params['from'] = origin
      req.params['to'] = destination
    end
    parse(response)
  end

  def self.conn
    Faraday.new(
      url: ENV['MAP_URL'],
      headers: { 'Content-Type' => 'application/json' }
    )
  end
end
