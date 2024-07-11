# frozen_string_literal: true

module Api
  class CustomRegistrationsController < DeviseTokenAuth::RegistrationsController
    before_action :validate_password, only: %i[destroy]

    private

    def validate_password
      return if @resource.valid_password?(params[:password])

      render json: { error: 'Invalid password' }, status: :unauthorized
    end
  end
end
