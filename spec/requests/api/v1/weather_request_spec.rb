require 'rails_helper'

RSpec.describe 'Weather API' do
  describe 'happy paths' do
    it 'returns json of weather data for location' do
      location = 'denver,co'

      map_body = File.read('spec/fixtures/map_data_denver.json')
      stub_request(:get, "#{ENV['MAP_URL']}geocoding/v1/address?key=#{ENV['MAP_API_KEY']}&location=#{location}").
           to_return(status: 200, body: map_body, headers: {})

     weather_body = File.read('spec/fixtures/weather_data_denver.json')
     stub_request(:get, "#{ENV['WEATHER_URL']}onecall?appid=#{ENV['WEATHER_API_KEY']}&exclude=minutely,alerts&lat=39.738453&lon=-104.984853&units=imperial").
        to_return(status: 200, body: weather_body, headers: {})

      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful
      weather = JSON.parse(response.body, symbolize_names: true)

      expect(weather).to be_a(Hash)
      expect(weather).to have_key(:data)
      expect(weather[:data]).to be_a(Hash)

      expect(weather[:data]).to have_key(:id)
      expect(weather[:data][:id]).to eq(nil)
      expect(weather[:data]).to have_key(:type)
      expect(weather[:data][:type]).to eq('forecast')
      expect(weather[:data]).to have_key(:attributes)
      expect(weather[:data][:attributes]).to be_a(Hash)

      expect(weather[:data][:attributes]).to have_key(:current_weather)
      expect(weather[:data][:attributes][:current_weather]).to be_a(Hash)
      expect(weather[:data][:attributes][:current_weather]).to have_key(:datetime)
      expect(weather[:data][:attributes][:current_weather][:datetime]).to be_a(String)
      expect(weather[:data][:attributes][:current_weather]).to have_key(:sunrise)
      expect(weather[:data][:attributes][:current_weather][:sunrise]).to be_a(String)
      expect(weather[:data][:attributes][:current_weather]).to have_key(:sunset)
      expect(weather[:data][:attributes][:current_weather][:sunset]).to be_a(String)
      expect(weather[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(weather[:data][:attributes][:current_weather][:temperature]).to be_a(Numeric)
      expect(weather[:data][:attributes][:current_weather]).to have_key(:feels_like)
      expect(weather[:data][:attributes][:current_weather][:feels_like]).to be_a(Numeric)
      expect(weather[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(weather[:data][:attributes][:current_weather][:humidity]).to be_a(Numeric)
      expect(weather[:data][:attributes][:current_weather]).to have_key(:uvi)
      expect(weather[:data][:attributes][:current_weather][:uvi]).to be_a(Numeric)
      expect(weather[:data][:attributes][:current_weather]).to have_key(:visibility)
      expect(weather[:data][:attributes][:current_weather][:visibility]).to be_a(Numeric)
      expect(weather[:data][:attributes][:current_weather]).to have_key(:conditions)
      expect(weather[:data][:attributes][:current_weather][:conditions]).to be_a(String)
      expect(weather[:data][:attributes][:current_weather]).to have_key(:icon)
      expect(weather[:data][:attributes][:current_weather][:icon]).to be_a(String)

      expect(weather[:data][:attributes]).to have_key(:daily_weather)
      expect(weather[:data][:attributes][:daily_weather]).to be_an(Array)
      expect(weather[:data][:attributes][:daily_weather].count).to eq(5)
      weather[:data][:attributes][:daily_weather].each do |day|
        expect(day).to have_key(:date)
        expect(day[:date]).to be_a(String)
        expect(day).to have_key(:sunrise)
        expect(day[:sunrise]).to be_a(String)
        expect(day).to have_key(:sunset)
        expect(day[:sunset]).to be_a(String)
        expect(day).to have_key(:max_temp)
        expect(day[:max_temp]).to be_a(Numeric)
        expect(day).to have_key(:min_temp)
        expect(day[:min_temp]).to be_a(Numeric)
        expect(day).to have_key(:conditions)
        expect(day[:conditions]).to be_a(String)
        expect(day).to have_key(:icon)
        expect(day[:icon]).to be_a(String)
      end

      expect(weather[:data][:attributes]).to have_key(:hourly_weather)
      expect(weather[:data][:attributes][:hourly_weather]).to be_an(Array)
      expect(weather[:data][:attributes][:hourly_weather].count).to eq(8)
      weather[:data][:attributes][:hourly_weather].each do |hour|
        expect(hour).to have_key(:time)
        expect(hour[:time]).to be_a(String)
        expect(hour).to have_key(:wind_speed)
        expect(hour[:wind_speed]).to be_a(String)
        expect(hour).to have_key(:wind_direction)
        expect(hour[:wind_direction]).to be_a(String)
        expect(hour).to have_key(:conditions)
        expect(hour[:conditions]).to be_a(String)
        expect(hour).to have_key(:icon)
        expect(hour[:icon]).to be_a(String)
      end
    end
  end
end
