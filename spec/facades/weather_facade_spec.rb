require 'rails_helper'

RSpec.describe WeatherFacade do
  it 'returns an forecast object' do
    latitude = 39.738453
    longitude = -104.984853
    weather_body = File.read('spec/fixtures/weather_data_denver.json')
    stub_request(:get, "#{ENV['WEATHER_URL']}onecall?appid=#{ENV['WEATHER_API_KEY']}&exclude=minutely,alerts&lat=#{latitude}&lon=#{longitude}&units=imperial").
       to_return(status: 200, body: weather_body, headers: {})

    result = WeatherFacade.weather_for_location(latitude, longitude)

    expect(result).to be_a(Forecast)
  end
end
