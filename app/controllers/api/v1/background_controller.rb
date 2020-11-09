class Api::V1::BackgroundController < ApplicationController
  def show
    background = ImageFacade.background_of_location(params[:location])
    render json: ImageSerializer.new(background)
  end
end
