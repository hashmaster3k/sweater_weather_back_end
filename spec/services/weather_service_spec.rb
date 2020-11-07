require 'rails_helper'

RSpec.describe WeatherService do
  it 'returns a json of weather data based on coordinates' do
    latitude = 39.738453
    longitude = -104.984853
    weather_body = File.read('spec/fixtures/weather_data_denver.json')
    stub_request(:get, "#{ENV['WEATHER_URL']}onecall?appid=#{ENV['WEATHER_API_KEY']}&exclude=minutely,alerts&lat=#{latitude}&lon=#{longitude}&units=imperial").
       to_return(status: 200, body: weather_body, headers: {})

    result = WeatherService.onecall_weather(latitude, longitude)

    expect(result).to be_a(Hash)
    expect(result).to_not have_key(:alerts)
    expect(result).to_not have_key(:minutely)
    expect(result).to have_key(:current)
    expect(result).to have_key(:daily)
    expect(result).to have_key(:hourly)

    expect(result[:current]).to have_key(:dt)
    expect(result[:current][:dt]).to be_a(Numeric)
    expect(result[:current]).to have_key(:sunrise)
    expect(result[:current][:sunrise]).to be_a(Numeric)
    expect(result[:current]).to have_key(:sunset)
    expect(result[:current][:sunset]).to be_a(Numeric)
    expect(result[:current]).to have_key(:temp)
    expect(result[:current][:temp]).to be_a(Numeric)
    expect(result[:current]).to have_key(:feels_like)
    expect(result[:current][:feels_like]).to be_a(Numeric)
    expect(result[:current]).to have_key(:humidity)
    expect(result[:current][:humidity]).to be_a(Numeric)
    expect(result[:current]).to have_key(:uvi)
    expect(result[:current][:uvi]).to be_a(Numeric)
    expect(result[:current]).to have_key(:visibility)
    expect(result[:current][:visibility]).to be_a(Numeric)
    expect(result[:current]).to have_key(:weather)
    expect(result[:current][:weather]).to be_a(Array)
    expect(result[:current][:weather].count).to eq(1)
    expect(result[:current][:weather].first).to be_a(Hash)
    expect(result[:current][:weather].first).to have_key(:description)
    expect(result[:current][:weather].first[:description]).to be_a(String)
    expect(result[:current][:weather].first).to have_key(:icon)
    expect(result[:current][:weather].first[:icon]).to be_a(String)

    expect(result[:daily]).to be_an(Array)

    result[:daily].each do |day|
      expect(day).to have_key(:dt)
      expect(day[:dt]).to be_a(Numeric)
      expect(day).to have_key(:sunrise)
      expect(day[:sunrise]).to be_a(Numeric)
      expect(day).to have_key(:sunset)
      expect(day[:sunset]).to be_a(Numeric)
      expect(day).to have_key(:temp)
      expect(day[:temp]).to be_a(Hash)
      expect(day[:temp]).to have_key(:max)
      expect(day[:temp][:max]).to be_a(Numeric)
      expect(day[:temp]).to have_key(:min)
      expect(day[:temp][:min]).to be_a(Numeric)

      expect(day).to have_key(:weather)
      expect(day[:weather]).to be_a(Array)
      expect(day[:weather].count).to eq(1)
      expect(day[:weather].first).to be_a(Hash)
      expect(day[:weather].first).to have_key(:description)
      expect(day[:weather].first[:description]).to be_a(String)
      expect(day[:weather].first).to have_key(:icon)
      expect(day[:weather].first[:icon]).to be_a(String)
    end

    expect(result[:hourly]).to be_an(Array)

    result[:hourly].each do |hour|
      expect(hour).to have_key(:dt)
      expect(hour[:dt]).to be_a(Numeric)
      expect(hour).to have_key(:wind_speed)
      expect(hour[:wind_speed]).to be_a(Numeric)
      expect(hour).to have_key(:wind_deg)
      expect(hour[:wind_deg]).to be_a(Numeric)


      expect(hour).to have_key(:weather)
      expect(hour[:weather]).to be_a(Array)
      expect(hour[:weather].count).to eq(1)
      expect(hour[:weather].first).to be_a(Hash)
      expect(hour[:weather].first).to have_key(:description)
      expect(hour[:weather].first[:description]).to be_a(String)
      expect(hour[:weather].first).to have_key(:icon)
      expect(hour[:weather].first[:icon]).to be_a(String)
    end
  end
end
