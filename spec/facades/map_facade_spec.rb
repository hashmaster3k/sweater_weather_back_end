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

  it 'returns array with time travel string and total hours' do
    origin = 'Denver,CO'
    destination = 'Pueblo,CO'

    distance_body = File.read('spec/fixtures/route_data_denver_pueblo.json')
    stub_request(:get, "#{ENV['MAP_URL']}directions/v2/route?from=#{origin}&key=#{ENV['MAP_API_KEY']}&to=#{destination}").
       to_return(status: 200, body: distance_body, headers: {})

    result = MapFacade.travel_time_between_two_locations(origin, destination)

    expect(result).to be_an(Array)
    expect(result.count).to eq(2)
    expect(result.first).to be_a(String)
    expect(result.last).to be_a(Numeric)
  end

  it 'returns array with impossible route string and 0 hours' do
    origin = 'Miami, FL'
    destination = 'Havana, Cuba'

    error_body = File.read('spec/fixtures/route_error.json')
    stub_request(:get, "#{ENV['MAP_URL']}directions/v2/route?from=#{origin}&key=#{ENV['MAP_API_KEY']}&to=#{destination}").
       to_return(status: 200, body: error_body, headers: {})

    result = MapFacade.travel_time_between_two_locations(origin, destination)

    expect(result).to be_an(Array)
    expect(result.count).to eq(2)
    expect(result.first).to be_a(String)
    expect(result.last).to be_a(Numeric)
  end

  it 'can convert seconds to string time' do
    expect(MapFacade.send(:convert_to_readable_time, 923823)).to eq("10 day 16 hr 37 min")
    expect(MapFacade.send(:convert_to_readable_time, 9238)).to eq("2 hr 33 min")
    expect(MapFacade.send(:convert_to_readable_time, 923)).to eq("15 min")
  end
end
