# frozen_string_literal: true

require 'api_constraints'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/custom_registrations'
    }

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :contacts
      resources :addresses, only: :show
    end
  end
end
