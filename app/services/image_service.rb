class ImageService
  def self.background_for_location(location)
    resp = Faraday.get("#{ENV['IMAGE_URL']}/images/search?") do |req|
      req.params['q'] = location
      req.params['count'] = 1
      req.params['safeSearch'] = 'Strict'
      req.headers['Ocp-Apim-Subscription-Key'] = ENV['IMAGE_API_KEY']
    end

    JSON.parse(resp.body, symbolize_names: true)
  end
end
