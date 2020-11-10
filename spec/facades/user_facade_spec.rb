require 'rails_helper'

RSpec.describe UserFacade do
  describe 'happy path' do
    it 'should return a saved user object' do
      params = {
                "email": "john@example.com",
                "password": "password",
                "password_confirmation": "password"
                }
      user = UserFacade.create(params)

      expect(User.count).to eq(1)
      expect(user).to be_a(User)
    end
  end

  describe 'sad path' do
    it 'should return a nil user object for non-matching passwords' do
      params = {
                "email": "john@example.com",
                "password": "password",
                "password_confirmation": "word pass"
                }
      user = UserFacade.create(params)

      expect(User.count).to eq(0)
      expect(user.id).to eq(nil)
      expect(user.created_at).to eq(nil)
      expect(user.updated_at).to eq(nil)
    end

    it 'should return a nil user object for un-unique email' do
      User.create!( email: 'whatever@example.com',
                    password: 'password',
                    api_key: SecureRandom.hex )

      params = {
                "email": "whatever@example.com",
                "password": "password",
                "password_confirmation": "password"
                }
      user = UserFacade.create(params)

      expect(User.count).to eq(1)
      expect(user.id).to eq(nil)
      expect(user.created_at).to eq(nil)
      expect(user.updated_at).to eq(nil)
    end
  end
end
