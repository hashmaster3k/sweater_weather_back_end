require 'rails_helper'

RSpec.describe 'Weather API' do
  describe 'happy paths' do
    it 'has a proper route, controller and action' do
      location = 'denver,co'

      body = File.read('spec/fixtures/map_data_denver.json')
      stub_request(:get, "#{ENV['MAP_URL']}geocoding/v1/address?key=#{ENV['MAP_API_KEY']}&location=#{location}").
           to_return(status: 200, body: body, headers: {})
           
      get '/api/v1/forecast?location=denver,co'
    end
  end
end
