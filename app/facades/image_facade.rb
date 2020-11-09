class ImageFacade
  def self.background_of_location(location)
    result = ImageService.background_for_location(location)
    Image.new(result)
  end
end
