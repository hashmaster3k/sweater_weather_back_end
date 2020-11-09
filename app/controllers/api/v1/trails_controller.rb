class Api::V1::TrailsController < ApplicationController
  def index
    trails = TrailFacade.trails_near_location(params[:location])
    render json: TrailSerializer.new(trails)
  end
end
