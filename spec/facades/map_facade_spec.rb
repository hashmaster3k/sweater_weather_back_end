require 'rails_helper'

RSpec.describe MapFacade do
  it 'returns an coordinate object' do
    location = 'denver,co'

    body = File.read('spec/fixtures/map_data_denver.json')
    stub_request(:get, "#{ENV['MAP_URL']}geocoding/v1/address?key=#{ENV['MAP_API_KEY']}&location=#{location}").
         to_return(status: 200, body: body, headers: {})

    result = MapFacade.coordinates_for_location(location)

    expect(result).to be_a(Coordinate)
  end

  it 'can get distance distance_between_two_locations' do
    lat1 = 39.738453
    long1 = -104.982323
    lat2 = 39.95816
    long2 = -105.257965

    distance_body = File.read('spec/fixtures/distance_data_for_trail.json')
    stub_request(:get, "#{ENV['MAP_URL']}directions/v2/route?from=#{lat1},#{long1}&key=#{ENV['MAP_API_KEY']}&to=#{lat2},#{long2}").
       to_return(status: 200, body: distance_body, headers: {})

    distance = MapFacade.distance_between_two_locations(lat1, long1, lat2,long2)

    expect(distance).to be_a(Numeric)
  end
end
