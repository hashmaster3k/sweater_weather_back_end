class Image
  attr_reader :id, :image_url, :source

  def initialize(data)
    @id = nil
    @image_url = data[:value].first[:contentUrl]
    @source = 'bing search'
  end
end
