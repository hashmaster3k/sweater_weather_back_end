class Api::V1::WeatherController < ApplicationController
  def index
    coordinates = MapFacade.coordinates_for_location(params[:location])
    weather = WeatherFacade.weather_for_location(coordinates.latitude, coordinates.longitude)
    render json: ForecastSerializer.new(weather)
  end
end
