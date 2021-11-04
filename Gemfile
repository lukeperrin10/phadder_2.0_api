source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'active_model_serializers'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise', '~> 4.8'
gem 'devise_token_auth'
gem 'omniauth-facebook'
gem 'omniauth-rails_csrf_protection'
gem 'geocoder'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'rest-client'
gem 'state_machines-activerecord'

# gem "aws-sdk-s3", require: false

group :development, :test do
  gem 'coveralls', require: false
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec_junit_formatter', group: [:test]
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'state_machines-rspec'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end
