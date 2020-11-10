class Api::V1::RoadTripController < ApplicationController
  def create
    user = UserFacade.auth_key(params[:api_key])
    if user.nil?
      render json: { error: 'invalid key' }, status: :unauthorized
    else
      roadtrip = RoadTripFacade.trip_details(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(roadtrip)
    end
  end
end
