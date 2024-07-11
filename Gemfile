# frozen_string_literal: true

source 'https://rubygems.org'
ruby '3.3.1'
# Speeds up boot times through caching
gem 'bootsnap', require: false
# Validates and generates CPFs and CNPJs
gem 'cpf_cnpj'
# Token authentication for Rails API
gem 'devise_token_auth'
# Executes HTTP requests
gem 'faraday'
# Builds JSON APIs
gem 'jbuilder'
# Pagination for Rails
gem 'kaminari'
# PostgreSQL adapter for Rails
gem 'pg', '~> 1.1'
# HTTP server for Ruby/Rails
gem 'puma', '>= 5.0'
# Web application framework
gem 'rails', '~> 7.1.3', '>= 7.1.3.4'
# Swagger generators for RSpec
gem 'rswag-api'
# Swagger UI engine for API documentation
gem 'rswag-ui'
# Timezone data for Windows/JRuby
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  # Maintains clean DB state for testing
  gem 'database_cleaner-active_record'
  # Debugging tool for Ruby
  gem 'debug', platforms: %i[mri windows]
  # Simplifies test object creation
  gem 'factory_bot_rails'
  # Generates fake data
  gem 'faker'
  # Opens sent emails in the browser window
  gem 'letter_opener'
  # Combines pry with byebug for debugging
  gem 'pry-byebug'
  # Testing framework for Rails
  gem 'rspec-rails', '~> 6.0'
  # Swagger-based DSL for testing API operations
  gem 'rswag-specs'
  # Provides RSpec- and Minitest-compatible one-liners to test common Rails functionalities
  gem 'shoulda-matchers'
  # Code coverage analysis tool for Ruby
  gem 'simplecov'
  # JSON formatter for SimpleCov output
  gem 'simplecov_json_formatter'
  # Stubs and sets expectations on HTTP requests
  gem 'webmock'
end
