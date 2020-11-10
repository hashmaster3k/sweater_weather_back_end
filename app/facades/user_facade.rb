class UserFacade
  def self.auth(user_info)
    user = User.find_by(email: user_info[:email])
    return user if user && user.authenticate(user_info[:password])
  end

  def self.create(user_info)
    User.create(user_info.merge(api_key: unique_api_key))
  end

  private_class_method def self.unique_api_key
    key = SecureRandom.hex
    if User.find_by(api_key: key)
      unique_api_key
    else
      key
    end
  end
end
