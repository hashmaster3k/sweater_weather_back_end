require 'rails_helper'

RSpec.describe DailyWeather do
  it 'can create a list of daily objects' do
    raw_weather = File.read('spec/fixtures/weather_data_denver.json')
    parsed_weather = JSON.parse(raw_weather, symbolize_names: true)
    dailys = DailyWeather.create_list(parsed_weather[:daily][0..4])

    expect(dailys).to be_an(Array)
    expect(dailys.count).to eq(5)

    dailys.each do |day|
      expect(day).to be_a(DailyWeather)
      expect(day.date).to be_a(String)
      expect(day.sunrise).to be_a(Time)
      expect(day.sunset).to be_a(Time)
      expect(day.max_temp).to be_a(Numeric)
      expect(day.min_temp).to be_a(Numeric)
      expect(day.conditions).to be_a(String)
      expect(day.icon).to be_a(String)
    end
  end
end
