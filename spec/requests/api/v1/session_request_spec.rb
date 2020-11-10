require 'rails_helper'

RSpec.describe 'Sessions API' do
  describe 'happy path' do
    it 'finds user, confirms identity and returns user info as json' do
      User.create!( email: 'whatever@example.com',
                    password: 'password',
                    api_key: SecureRandom.hex )

      headers = { 'Content-Type': 'application/json',
                  'Accept': 'application/json' }

      body = { 'email': 'whatever@example.com',
               'password': 'password' }

      post "/api/v1/sessions", headers: headers, params: JSON.generate(body)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      parsed = JSON.parse(response.body, symbolize_names: true)
      
      expect(parsed).to be_a(Hash)
      expect(parsed).to have_key(:data)
      expect(parsed[:data]).to be_a(Hash)
      expect(parsed[:data]).to have_key(:id)
      expect(parsed[:data]).to have_key(:type)
      expect(parsed[:data][:type]).to be_a(String)
      expect(parsed[:data]).to have_key(:attributes)
      expect(parsed[:data][:attributes]).to be_a(Hash)
      expect(parsed[:data][:attributes]).to have_key(:email)
      expect(parsed[:data][:attributes][:email]).to be_a(String)
      expect(parsed[:data][:attributes]).to have_key(:api_key)
      expect(parsed[:data][:attributes][:api_key]).to be_a(String)
    end
  end
end
