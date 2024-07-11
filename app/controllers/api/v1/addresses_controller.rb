# frozen_string_literal: true

module Api
  module V1
    class AddressesController < ApplicationController
      before_action :authenticate_api_user!

      def show
        @address = ViaCepGateway.by_zipcode(zipcode: params[:id])
        return if @address.present?

        render json: { message: I18n.t('errors.messages.address_via_cep_not_found') }, status: :unprocessable_entity
      end
    end
  end
end
