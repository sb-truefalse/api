source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'active_model_serializers', '~> 0.10.9'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'carrierwave', '~> 1.0'
gem 'countries'
gem 'globalize', git: 'https://github.com/globalize/globalize'
gem 'kaminari'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2.3'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'sqlite3', '~> 1.3.13'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg', '0.20'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
