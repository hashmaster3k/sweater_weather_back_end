require 'rails_helper'

RSpec.describe HourlyWeather do
  it 'can create a list of hourly weather objects' do
    raw_weather = File.read('spec/fixtures/weather_data_denver.json')
    parsed_weather = JSON.parse(raw_weather, symbolize_names: true)
    hours = HourlyWeather.create_list(parsed_weather[:hourly][0..7])

    expect(hours).to be_an(Array)
    expect(hours.count).to eq(8)

    hours.each do |hour|
      expect(hour).to be_a(HourlyWeather)
      expect(hour.time).to be_a(String)
      expect(hour.predicted_temp).to be_a(Numeric)
      expect(hour.wind_speed).to be_a(String)
      expect(hour.wind_direction).to be_a(String)
      expect(hour.conditions).to be_a(String)
      expect(hour.icon).to be_a(String)
    end
  end
end
