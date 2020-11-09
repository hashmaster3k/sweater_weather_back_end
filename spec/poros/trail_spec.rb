require 'rails_helper'

RSpec.describe Trail do
  it 'can create a trail object' do
    latitude = 39.738453
    longitude = -104.984853
    data = {
            results: [{
              locations: [{
                latLng: {
                  lat: latitude,
                  lng: longitude
                }
              }]
            }]
          }
    coordinates = Coordinate.new(data)

    raw_trail_data = File.read('spec/fixtures/trails_data_denver.json')
    parsed_trail_data = JSON.parse(raw_trail_data, symbolize_names: true)

    raw_weather_data = File.read('spec/fixtures/weather_data_denver.json')
    parsed_weather_data = JSON.parse(raw_weather_data, symbolize_names: true)
    weather = Forecast.new(parsed_weather_data)

    distance_body = File.read('spec/fixtures/distance_data_for_trail.json')
    stub_request(:get, "#{ENV['MAP_URL']}directions/v2/route?from=#{latitude},#{longitude}&key=#{ENV['MAP_API_KEY']}&to=39.9388,-105.2582").
       to_return(status: 200, body: distance_body, headers: {})

    trail = Trail.new(parsed_trail_data, weather, 'denver,co', coordinates)

    expect(trail).to be_a(Trail)
  end
end
