class Api::V1::FilmsController < Api::V1::ApplicationController
  def index
    films_paginated = Film.recent
                          .filtered(filters_params)
                          .sorted(sort_params)
                          .page(current_page)
                          .per(per_page)

    render json: films_paginated, scope: :index
  end

  def show
    film = Film.find(params[:id])
    render json: film
  end

  def create
    film = Film.new(film_params)
    film.save!
    render json: film, status: :created
  rescue
    render_unprocessable_entity
  end

  def update
    film = find_film
    film.update_attributes!(film_params)
    render json: film, status: :ok
  rescue
    render_unprocessable_entity
  end

  def destroy
    film = find_film
    film.destroy
    head :no_content
  end

  protected

  def find_film
    Film.find(params[:id])
  end

  def render_unprocessable_entity(film)
    render json: film,
           adapter: :json_api,
           serializer: ActiveModel::Serializer::ErrorSerializer,
           status: :unprocessable_entity
  end

  private

  def film_params
    params.require(:data)
          .require(:attributes)
          .permit(
            :local,
            :title,
            :date,
            :description,
            :rating,
            :avatar,
            genre_ids: [],
            film_countries_attributes: [[:country]]
          ) ||
      ActionController::Parameters.new
  end

  def sort_params
    return ActionController::Parameters.new unless params[:sort]

    delete_empty_params params.require(:sort).permit(:year, :rating)
  end

  def filters_params
    params[:filters][:genres] ||= []
    delete_empty_params params.require(:filters).permit(
      :title, :year, :rating, :country, genres: []
    )
  rescue
    ActionController::Parameters.new
  end
end
