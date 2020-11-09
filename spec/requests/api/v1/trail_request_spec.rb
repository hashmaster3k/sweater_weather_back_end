require 'rails_helper'

RSpec.describe 'Trail API' do
  describe 'happy paths' do
    it 'returns json of trail data for location' do
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

      get "/api/v1/trails?location=#{location}"

      expect(response).to be_successful
      trail = JSON.parse(response.body, symbolize_names: true)

      expect(trail).to be_a(Hash)
      expect(trail).to have_key(:data)
      expect(trail[:data]).to be_a(Hash)

      expect(trail[:data]).to have_key(:id)
      expect(trail[:data][:id]).to eq(nil)
      expect(trail[:data]).to have_key(:type)
      expect(trail[:data][:type]).to eq('trail')
      expect(trail[:data]).to have_key(:attributes)
      expect(trail[:data][:attributes]).to be_a(Hash)

      attributes = trail[:data][:attributes]

      expect(attributes).to have_key(:location)
      expect(attributes[:location]).to be_a(String)
      expect(attributes).to have_key(:forecast)
      expect(attributes[:forecast]).to be_a(Hash)
      expect(attributes[:forecast]).to have_key(:summary)
      expect(attributes[:forecast][:summary]).to be_a(String)
      expect(attributes[:forecast]).to have_key(:temperature)
      expect(attributes[:forecast][:temperature]).to be_a(Numeric)
      expect(attributes).to have_key(:trails)
      expect(attributes[:trails]).to be_a(Array)

      attributes[:trails].each do |trail|
        expect(trail).to have_key(:name)
        expect(trail[:name]).to be_a(String)
        expect(trail).to have_key(:summary)
        expect(trail[:summary]).to be_a(String)
        expect(trail).to have_key(:difficulty)
        expect(trail[:difficulty]).to be_a(String)
        expect(trail).to have_key(:location)
        expect(trail[:location]).to be_a(String)
        expect(trail).to have_key(:distance_to_trail)
        expect(trail[:distance_to_trail]).to be_a(Numeric)
      end
    end
  end
end
