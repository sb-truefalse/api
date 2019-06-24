class Api::V1::GenresController < Api::V1::ApplicationController
  def index
  	genres = Genre.all
    render json: genres, status: :ok
  end
end