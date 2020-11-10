class UserFacade
  def self.create(params)
    User.create(params.merge(api_key: unique_api_key))
  end

  private

  def self.unique_api_key
    key = SecureRandom.hex
    if User.find_by(api_key: key)
      unique_api_key
    else
      return key
    end
  end
end
