class UserFacade
  def self.create(params)
    if passwords_match?(params[:password], params[:password_confirmation])
      User.create(params.merge(api_key: SecureRandom.hex))
    else
    end
  end

  private

  def self.passwords_match?(password, confirmation)
    password == confirmation
  end
end
