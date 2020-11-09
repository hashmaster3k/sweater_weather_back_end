class ImageSerializer
  include JSONAPI::Serializer
  attributes :image_url, :source
end
