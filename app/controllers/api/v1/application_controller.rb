class Api::V1::ApplicationController < ApplicationController
  #skip_before_action :verify_authenticity_token
  #before_action :request_xhr_validate
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
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def default_url_options
    { locale: I18n.locale }
  end

  # For 'fast_jsonapi'
  # def render(options={})
    # if options[:opts]
      # options[:json] = serializer.new(options[:json], options[:opts])
    # else
      # options[:json] = serializer.new(options[:json])
    # end
    # super(options)
  # end
end
