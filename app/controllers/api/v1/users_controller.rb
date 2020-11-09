class Api::V1::UsersController < ApplicationController
  def create
    user = UserFacade.create(user_params)
    unless user.id == nil
      render json: UserSerializer.new(user), status: 201
    else
      render json: errors(user), status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def errors(user)
    error_list = 'Error: '
    user.errors.messages.each do |message|
      error_list.concat("#{message.first.to_s} #{message.second.first}")
    end
    error_list
  end
end
