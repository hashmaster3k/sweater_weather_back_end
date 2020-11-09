require 'rails_helper'

RSpec.describe MapService do
  it 'returns a json of map data based on location' do
    location = 'denver,co'

    body = File.read('spec/fixtures/map_data_denver.json')
    stub_request(:get, "#{ENV['MAP_URL']}geocoding/v1/address?key=#{ENV['MAP_API_KEY']}&location=#{location}").
         to_return(status: 200, body: body, headers: {})

    result = MapService.geocoding_address(location)

    expect(result).to be_a(Hash)
    expect(result).to have_key(:results)
    expect(result[:results]).to be_an(Array)
    expect(result[:results].first).to be_a(Hash)
    expect(result[:results].first).to have_key(:locations)
    expect(result[:results].first[:locations]).to be_an(Array)
    expect(result[:results].first[:locations].first).to be_a(Hash)
    expect(result[:results].first[:locations].first).to have_key(:latLng)
    expect(result[:results].first[:locations].first[:latLng]).to be_a(Hash)
    expect(result[:results].first[:locations].first[:latLng]).to have_key(:lat)
    expect(result[:results].first[:locations].first[:latLng]).to have_key(:lng)
    expect(result[:results].first[:locations].first[:latLng][:lat]).to be_a(Numeric)
    expect(result[:results].first[:locations].first[:latLng][:lng]).to be_a(Numeric)
  end

  it 'returns json data about route distance_between_two_locations' do
    lat1 = 39.738453
    long1 = -104.982323
    lat2 = 39.95816
    long2 = -105.257965

    distance_body = File.read('spec/fixtures/distance_data_for_trail.json')
    stub_request(:get, "#{ENV['MAP_URL']}directions/v2/route?from=#{lat1},#{long1}&key=#{ENV['MAP_API_KEY']}&to=#{lat2},#{long2}").
       to_return(status: 200, body: distance_body, headers: {})

    result = MapService.distance_between_two_locations(lat1, long1, lat2,long2)

    expect(result).to be_a(Hash)
    expect(result).to have_key(:route)
    expect(result[:route]).to be_a(Hash)
    expect(result[:route]).to have_key(:distance)
    expect(result[:route][:distance]).to be_a(Numeric)
  end
end
