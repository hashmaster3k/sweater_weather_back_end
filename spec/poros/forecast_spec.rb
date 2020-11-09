require 'rails_helper'

RSpec.describe Forecast do
  it 'can create a forecast object' do
    raw_data = File.read('spec/fixtures/weather_data_denver.json')
    parsed_data = JSON.parse(raw_data, symbolize_names: true)
    forecast = Forecast.new(parsed_data)

    expect(forecast).to be_a(Forecast)

    expect(forecast.current_weather).to be_a(CurrentWeather)
    expect(forecast.current_weather.datetime).to be_a(Time)
    expect(forecast.current_weather.sunrise).to be_a(Time)
    expect(forecast.current_weather.sunset).to be_a(Time)
    expect(forecast.current_weather.temperature).to be_a(Numeric)
    expect(forecast.current_weather.feels_like).to be_a(Numeric)
    expect(forecast.current_weather.humidity).to be_a(Numeric)
    expect(forecast.current_weather.uvi).to be_a(Numeric)
    expect(forecast.current_weather.visibility).to be_a(Numeric)
    expect(forecast.current_weather.conditions).to be_a(String)
    expect(forecast.current_weather.icon).to be_a(String)

    expect(forecast.daily_weather).to be_an(Array)
    expect(forecast.daily_weather.count).to eq(5)
    forecast.daily_weather.each do |day|
      expect(day).to be_a(DailyWeather)
      expect(day.date).to be_a(String)
      expect(day.sunrise).to be_a(Time)
      expect(day.sunset).to be_a(Time)
      expect(day.max_temp).to be_a(Numeric)
      expect(day.min_temp).to be_a(Numeric)
      expect(day.conditions).to be_a(String)
      expect(day.icon).to be_a(String)
    end


    expect(forecast.hourly_weather).to be_an(Array)
    expect(forecast.hourly_weather.count).to eq(8)
    forecast.hourly_weather.each do |hour|
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
