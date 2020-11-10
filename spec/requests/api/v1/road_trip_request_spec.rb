require 'rails_helper'

RSpec.describe 'RoadTrip API' do
  describe 'happy path' do
    it 'returns JSON of road trip information' do
      origin = 'Denver,CO'
      destination = 'Pueblo,CO'
      api_key = SecureRandom.hex

      User.create!( email: 'whatever@example.com',
                    password: 'password',
                    api_key: api_key )

      headers = { 'Content-Type': 'application/json',
                  'Accept': 'application/json' }

      request_body = { "origin": origin,
                       "destination": destination,
                       "api_key": api_key }

      distance_body = File.read('spec/fixtures/route_data_denver_pueblo.json')
      stub_request(:get, "#{ENV['MAP_URL']}directions/v2/route?from=#{origin}&key=#{ENV['MAP_API_KEY']}&to=#{destination}").
         to_return(status: 200, body: distance_body, headers: {})

      coordinate_body = File.read('spec/fixtures/route_data_pueblo.json')
      stub_request(:get, "#{ENV['MAP_URL']}geocoding/v1/address?key=#{ENV['MAP_API_KEY']}&location=#{destination}").
         to_return(status: 200, body: coordinate_body, headers: {})

      weather_body = File.read('spec/fixtures/weather_data_pueblo.json')
      stub_request(:get, "#{ENV['WEATHER_URL']}onecall?appid=#{ENV['WEATHER_API_KEY']}&exclude=minutely,alerts&lat=38.265425&lon=-104.610415&units=imperial").
          to_return(status: 200, body: weather_body, headers: {})

      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to be_a(Hash)
      expect(parsed).to have_key(:data)
      expect(parsed[:data]).to be_a(Hash)
      expect(parsed[:data]).to have_key(:id)
      expect(parsed[:data][:id]).to eq(nil)
      expect(parsed[:data]).to have_key(:type)
      expect(parsed[:data][:type]).to eq('road_trip')
      expect(parsed[:data]).to have_key(:attributes)
      expect(parsed[:data][:attributes]).to be_a(Hash)

      attributes = parsed[:data][:attributes]

      expect(attributes).to have_key(:start_city)
      expect(attributes[:start_city]).to be_a(String)
      expect(attributes).to have_key(:end_city)
      expect(attributes[:end_city]).to be_a(String)
      expect(attributes).to have_key(:travel_time)
      expect(attributes[:travel_time]).to be_a(String)
      expect(attributes).to have_key(:weather_at_eta)
      expect(attributes[:weather_at_eta]).to be_a(Hash)
      expect(attributes[:weather_at_eta]).to have_key(:temperature)
      expect(attributes[:weather_at_eta][:temperature]).to be_a(Numeric)
      expect(attributes[:weather_at_eta]).to have_key(:conditions)
      expect(attributes[:weather_at_eta][:conditions]).to be_a(String)
    end

    it 'returns JSON of data for impossible route' do
      origin = 'Miami, FL'
      destination = 'Havana, Cuba'
      api_key = SecureRandom.hex

      User.create!( email: 'whatever@example.com',
                    password: 'password',
                    api_key: api_key )

      headers = { 'Content-Type': 'application/json',
                  'Accept': 'application/json' }

      request_body = { "origin": origin,
                       "destination": destination,
                       "api_key": api_key }

      error_body = File.read('spec/fixtures/route_error.json')
      stub_request(:get, "#{ENV['MAP_URL']}directions/v2/route?from=#{origin}&key=#{ENV['MAP_API_KEY']}&to=#{destination}").
         to_return(status: 200, body: error_body, headers: {})

      map_body = File.read('spec/fixtures/map_data_cuba.json')
      stub_request(:get, "#{ENV['MAP_URL']}geocoding/v1/address?key=#{ENV['MAP_API_KEY']}&location=Havana,%20Cuba").
        to_return(status: 200, body: map_body, headers: {})

      weather_body = File.read('spec/fixtures/weather_data_pueblo.json')
      stub_request(:get, "#{ENV['WEATHER_URL']}onecall?appid=#{ENV['WEATHER_API_KEY']}&exclude=minutely,alerts&lat=23.137991&lon=-82.365856&units=imperial").
          to_return(status: 200, body: weather_body, headers: {})

      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed = JSON.parse(response.body, symbolize_names: true)
      attributes = parsed[:data][:attributes]

      expect(attributes).to have_key(:start_city)
      expect(attributes[:start_city]).to be_a(String)
      expect(attributes).to have_key(:end_city)
      expect(attributes[:end_city]).to be_a(String)
      expect(attributes).to have_key(:travel_time)
      expect(attributes[:travel_time]).to eq('impossible route')
      expect(attributes).to have_key(:weather_at_eta)
      expect(attributes[:weather_at_eta]).to eq(nil)
    end
  end

  describe 'sad path' do
    it 'returns 401 if api_key doesnt match' do
      origin = 'Denver,CO'
      destination = 'Pueblo,CO'

      User.create!( email: 'whatever@example.com',
                    password: 'password',
                    api_key: '123456789' )

      headers = { 'Content-Type': 'application/json',
                  'Accept': 'application/json' }

      request_body = { "origin": origin,
                       "destination": destination,
                       "api_key": '987654321' }

      post "/api/v1/road_trip", headers: headers, params: JSON.generate(request_body)

      expect(response.status).to eq(401)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed).to be_a(Hash)
      expect(parsed).to have_key(:error)
      expect(parsed[:error]).to eq('invalid key')
    end
  end
end
