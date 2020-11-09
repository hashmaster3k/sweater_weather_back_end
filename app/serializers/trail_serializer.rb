class TrailSerializer
  include JSONAPI::Serializer
  attributes :location, :forecast, :trails
end
