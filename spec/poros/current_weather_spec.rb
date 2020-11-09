require 'rails_helper'

RSpec.describe CurrentWeather do
  it 'can create a current weather object' do
    raw_weather = File.read('spec/fixtures/weather_data_denver.json')
    parsed_weather = JSON.parse(raw_weather, symbolize_names: true)
    current = CurrentWeather.new(parsed_weather[:current])

    expect(current).to be_a(CurrentWeather)
    expect(current.datetime).to be_a(Time)
    expect(current.sunrise).to be_a(Time)
    expect(current.sunset).to be_a(Time)
    expect(current.temperature).to be_a(Numeric)
    expect(current.feels_like).to be_a(Numeric)
    expect(current.humidity).to be_a(Numeric)
    expect(current.uvi).to be_a(Numeric)
    expect(current.visibility).to be_a(Numeric)
    expect(current.conditions).to be_a(String)
    expect(current.icon).to be_a(String)
  end
end
