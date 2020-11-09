class UserFacade
  def self.create(params)
    User.create(params.merge(api_key: SecureRandom.hex))
  end
end
