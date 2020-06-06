class Api::V1::ApplicationController < ApplicationController
  # skip_before_action :verify_authenticity_token
  # before_action :request_xhr_validate
  before_action :set_locale

  private

  def request_xhr_validate
    render json: nil unless request.xhr?
  end

  def current_page
    return 1 unless params[:page]
    return params[:page] if params[:page].is_a?(String)

    params.dig(:page, :number) if params[:page].is_a?(Hash)
  end

  def per_page
    return unless params[:page]
    return params[:per_page] if params[:per_page].is_a?(String)

    params.dig(:page, :size) if params[:page].is_a?(Hash)
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    available_locales.include?(parsed_locale) ? parsed_locale : nil
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def available_locales
    I18n.available_locales.map(&:to_s)
  end

  def delete_empty_params(params)
    params.delete_if { |_key, value| value.empty? }
  end
end
