require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require 'carrierwave'
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KinoApi
  class Application < Rails::Application
    config.load_defaults 5.2
    config.encoding = "utf-8"
    config.i18n.default = :en
    config.i18n.available_locales = [:en, :ru]
    config.api_only = true
    config.i18n.fallbacks = true
  end
end
