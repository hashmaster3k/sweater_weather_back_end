require 'rails_helper'

RSpec.describe 'Weather API' do
  describe 'happy paths' do
    it 'has a proper route, controller and action' do
      get '/api/v1/forecast?location=denver,co'
    end
  end
end
