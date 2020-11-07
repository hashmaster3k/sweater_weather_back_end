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
end
