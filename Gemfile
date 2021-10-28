source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise_token_auth'
gem 'rack-cors'

group :development, :test do
  gem 'coveralls', require: false
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'rspec_junit_formatter', group: [:test]
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'faker'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end
