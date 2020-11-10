class Api::V1::SessionsController < ApplicationController
  def create
    user = UserFacade.auth(user_params)
    render json: UserSerializer.new(user)
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
