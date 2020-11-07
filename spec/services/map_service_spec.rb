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
end
