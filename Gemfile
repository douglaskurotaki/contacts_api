# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.1'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3', '>= 7.1.3.4'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

gem 'cpf_cnpj'

gem 'devise_token_auth'

gem 'faraday'

group :development, :test do
  gem 'database_cleaner-active_record'
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails'
  # Generates fake data
  gem 'faker'
  # Pry is a runtime developer console and IRB
  gem 'pry-byebug'
  # Test
  gem 'rspec-rails', '~> 6.0'
  # Swagger-based DSL for describing and testing API operations
  gem 'rswag-specs'
  gem 'shoulda-matchers'

  gem 'simplecov'
  gem 'simplecov_json_formatter'
end

group :development do
  gem 'letter_opener'
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
