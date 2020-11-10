class Api::V1::SessionsController < ApplicationController
  def create
    user = UserFacade.auth(user_params)
    if user.nil?
      render json: { error: 'invalid credentials' }, status: :unauthorized
    else
      render json: UserSerializer.new(user)
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
