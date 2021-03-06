require 'rails_helper'

RSpec.describe 'User API' do
  describe 'happy paths' do
    it 'can create a new user' do
      headers = { 'Content-Type': 'application/json',
                  'Accept': 'application/json' }

      body = { 'email': 'whatever@example.com',
               'password': 'password',
               'password_confirmation': 'password' }

      post "/api/v1/users", headers: headers, params: JSON.generate(body)

      expect(response).to be_successful
      expect(response.status).to eq(201)

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
    it 'can create a new user without duplicating api_key' do
      existing_key = SecureRandom.hex

      allow(SecureRandom).to receive(:hex).and_return(existing_key, '1234567')

      User.create!( email: 'whatever@example.com',
                    password: 'password',
                    api_key: existing_key)

      headers = { 'Content-Type': 'application/json',
                  'Accept': 'application/json' }

      body = { 'email': 'john@example.com',
               'password': 'password',
               'password_confirmation': 'password' }

      post "/api/v1/users", headers: headers, params: JSON.generate(body)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:data][:attributes][:api_key]).to_not eq(existing_key)
    end
  end

  describe 'sad paths' do
    it 'email must be unique' do
      User.create!( email: 'whatever@example.com',
                    password: 'password',
                    api_key: SecureRandom.hex )

      headers = { 'Content-Type': 'application/json',
                  'Accept': 'application/json' }

      body = { 'email': 'whatever@example.com',
               'password': 'password',
               'password_confirmation': 'password' }

      post "/api/v1/users", headers: headers, params: JSON.generate(body)

      expect(response.status).to eq(400)
      expect(response.body).to eq('Error: email has already been taken')
    end

    it 'passwords do not match' do
      headers = { 'Content-Type': 'application/json',
                  'Accept': 'application/json' }

      body = { 'email': 'whatever@example.com',
               'password': 'password',
               'password_confirmation': 'wordpass' }

      post "/api/v1/users", headers: headers, params: JSON.generate(body)

      expect(response.status).to eq(400)
      expect(response.body).to eq("Error: password_confirmation doesn't match Password")
    end

    it 'email must be unique and passwords do not match' do
      User.create!( email: 'whatever@example.com',
                    password: 'password',
                    api_key: SecureRandom.hex )

      headers = { 'Content-Type': 'application/json',
                  'Accept': 'application/json' }

      body = { 'email': 'whatever@example.com',
               'password': 'password',
               'password_confirmation': 'wordpass' }

      post "/api/v1/users", headers: headers, params: JSON.generate(body)

      expect(response.status).to eq(400)
      expect(response.body).to eq("Error: email has already been taken, password_confirmation doesn't match Password")
    end

    it 'has missing fields' do
      headers = { 'Content-Type': 'application/json',
                  'Accept': 'application/json' }

      body = { 'email': '',
               'password': '',
               'password_confirmation': '' }

      post "/api/v1/users", headers: headers, params: JSON.generate(body)

      expect(response.status).to eq(400)
      expect(response.body).to eq("Error: email can't be blank, password can't be blank")
    end
  end
end
