require 'rails_helper'

RSpec.describe TrailFacade do
  it 'returns an trail object' do
    location = 'denver,co'
    latitude = 39.738453
    longitude = -104.984853

    map_body = File.read('spec/fixtures/map_data_denver.json')
    stub_request(:get, "#{ENV['MAP_URL']}geocoding/v1/address?key=#{ENV['MAP_API_KEY']}&location=#{location}").
         to_return(status: 200, body: map_body, headers: {})

    weather_body = File.read('spec/fixtures/weather_data_denver.json')
    stub_request(:get, "#{ENV['WEATHER_URL']}onecall?appid=#{ENV['WEATHER_API_KEY']}&exclude=minutely,alerts&lat=#{latitude}&lon=#{longitude}&units=imperial").
      to_return(status: 200, body: weather_body, headers: {})

    distance_body = File.read('spec/fixtures/distance_data_for_trail.json')
    stub_request(:get, "#{ENV['MAP_URL']}directions/v2/route?from=#{latitude},#{longitude}&key=#{ENV['MAP_API_KEY']}&to=39.9388,-105.2582").
       to_return(status: 200, body: distance_body, headers: {})

    trail_body = File.read('spec/fixtures/trails_data_denver.json')
    stub_request(:get, "#{ENV['TRAIL_URL']}/get-trails?key=#{ENV['TRAIL_API_KEY']}&lat=#{latitude}&lon=#{longitude}&maxDistance=10").
      to_return(status: 200, body: trail_body, headers: {})

    result = TrailFacade.trails_near_location(location)

    expect(result).to be_a(Trail)

    expect(result.forecast).to be_a(Hash)
    expect(result.forecast).to have_key(:summary)
    expect(result.forecast[:summary]).to be_a(String)
    expect(result.forecast).to have_key(:temperature)
    expect(result.forecast[:temperature]).to be_a(Numeric)

    expect(result.location).to be_a(String)

    expect(result.trails).to be_an(Array)
    expect(result.trails.count).to eq(1)
    expect(result.trails.first).to be_a(Hash)
    expect(result.trails.first).to have_key(:name)
    expect(result.trails.first[:name]).to be_a(String)
    expect(result.trails.first).to have_key(:summary)
    expect(result.trails.first[:summary]).to be_a(String)
    expect(result.trails.first).to have_key(:difficulty)
    expect(result.trails.first[:difficulty]).to be_a(String)
    expect(result.trails.first).to have_key(:location)
    expect(result.trails.first[:location]).to be_a(String)
    expect(result.trails.first).to have_key(:distance_to_trail)
    expect(result.trails.first[:distance_to_trail]).to be_a(Numeric)
  end
end
