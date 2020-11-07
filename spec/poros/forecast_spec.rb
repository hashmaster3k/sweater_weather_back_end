require 'rails_helper'

RSpec.describe Forecast do
  it 'can create a forecast object' do
    raw_data = File.read('spec/fixtures/weather_data_denver.json')
    parsed_data = JSON.parse(raw_data, symbolize_names: true)
    forecast = Forecast.new(parsed_data)

    expect(forecast).to be_a(Forecast)

    expect(forecast.current).to be_a(Hash)
    expect(forecast.current).to have_key(:datetime)
    expect(forecast.current[:datetime]).to be_a(Time)
    expect(forecast.current).to have_key(:sunrise)
    expect(forecast.current[:sunrise]).to be_a(Time)
    expect(forecast.current).to have_key(:sunset)
    expect(forecast.current[:sunset]).to be_a(Time)
    expect(forecast.current).to have_key(:temperature)
    expect(forecast.current[:temperature]).to be_a(Numeric)
    expect(forecast.current).to have_key(:feels_like)
    expect(forecast.current[:feels_like]).to be_a(Numeric)
    expect(forecast.current).to have_key(:humidity)
    expect(forecast.current[:humidity]).to be_a(Numeric)
    expect(forecast.current).to have_key(:uvi)
    expect(forecast.current[:uvi]).to be_a(Numeric)
    expect(forecast.current).to have_key(:visibility)
    expect(forecast.current[:visibility]).to be_a(Numeric)
    expect(forecast.current).to have_key(:conditions)
    expect(forecast.current[:conditions]).to be_a(String)
    expect(forecast.current).to have_key(:icon)
    expect(forecast.current[:icon]).to be_a(String)

    expect(forecast.daily).to be_an(Array)
    expect(forecast.daily.count).to eq(5)
    forecast.daily.each do |day|
      expect(day).to have_key(:date)
      expect(day[:date]).to be_a(String)
      expect(day).to have_key(:sunrise)
      expect(day[:sunrise]).to be_a(Time)
      expect(day).to have_key(:sunset)
      expect(day[:sunset]).to be_a(Time)
      expect(day).to have_key(:max_temp)
      expect(day[:max_temp]).to be_a(Numeric)
      expect(day).to have_key(:min_temp)
      expect(day[:min_temp]).to be_a(Numeric)
      expect(day).to have_key(:conditions)
      expect(day[:conditions]).to be_a(String)
      expect(day).to have_key(:icon)
      expect(day[:icon]).to be_a(String)
    end


    expect(forecast.hourly).to be_an(Array)
    expect(forecast.hourly.count).to eq(8)
    forecast.hourly.each do |hour|
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
