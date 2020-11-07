class Api::V1::WeatherController < ApplicationController
  def index
    MapFacade.coordinates_for_location(params[:location])
  end
end
