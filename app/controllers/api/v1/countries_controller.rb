class Api::V1::CountriesController < Api::V1::ApplicationController
  def index
    render json: Country.serializer(Country.all), status: :ok
  end
end
