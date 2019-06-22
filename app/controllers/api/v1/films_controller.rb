class Api::V1::FilmsController < Api::V1::ApplicationController
  def index
    films_paginated = Film.recent.filtered(filter_params).sorted(sort_params).
      page(current_page).per(per_page)
    # For 'fast_jsonapi'
    #opts = {
    #  links: {
    #    first: api_v1_films_path(per_page: per_page),
    #    self: api_v1_films_path(page: current_page, per_page: per_page),
    #    last: api_v1_films_path(page: films_paginated.total_pages, per_page: per_page)
    #  }
    #}
    render json: films_paginated #, opts: opts
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
    render json: film, adapter: :json_api, 
    serializer: ActiveModel::Serializer::ErrorSerializer,
    status: :unprocessable_entity
  end

  def update
    film = Film.find(params[:id])
    film.update_attributes!(film_params)
    render json: film, status: :ok
  rescue
    render json: film, adapter: :json_api,
      serializer: ActiveModel::Serializer::ErrorSerializer,
      status: :unprocessable_entity
  end

  def destroy
    film = Film.find(params[:id])
    film.destroy
    head :no_content
  end

  private

  def film_params
    params.require(:data).require(:attributes).
      permit(
        :local,
        :title,
        :date,
        :description,
        :rating,
        :avatar,
        #?genre_ids[]=1&genre_ids[]=2
        genre_ids: [],
        #?film_countries_attributes[][country]=RU&film_countries_attributes[][country]=UA
        film_countries_attributes: [[:country]]
      ) ||
    ActionController::Parameters.new
  end

  def sort_params
    # value: ASC || DESC
    params[:sort] ? params.require(:sort).
      permit(:year, :rating).delete_if {|key, value| value.empty? } :
      ActionController::Parameters.new
  end

  def filter_params
    params[:filter][:genres] ||= [] # filter[genres][]=1&filter[genres][]=2
    params.require(:filter).
      permit(:title, :year, :rating, :country , genres: []).delete_if {|key, value| value.empty?}
  rescue
    ActionController::Parameters.new
  end

  # For 'fast_jsonapi'
  # def serializer
    # FilmSerializer
  # end
end
