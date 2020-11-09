class Api::V1::UsersController < ApplicationController
  def create
    user = UserFacade.create(user_params)
    if user.id.nil?
      render json: errors(user), status: :bad_request
    else
      render json: UserSerializer.new(user), status: :created
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def errors(user)
    error_list = 'Error: '
    user.errors.messages.each do |message|
      error_list.concat("#{message.first} #{message.second.first}")
    end
    error_list
  end
end
