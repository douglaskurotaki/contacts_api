# frozen_string_literal: true

module Api
  module V1
    class AddressesController < ApplicationController
      before_action :authenticate_api_user!
      before_action :validate_zipcode, only: :show

      def show
        @address = ViaCepGateway.by_zipcode(zipcode: params[:id])
        return if @address.present?

        render json: { message: I18n.t('errors.messages.address_via_cep_not_found') }, status: :unprocessable_entity
      end

      private

      def validate_zipcode
        return if params[:id].present?

        render json: { message: I18n.t('errors.messages.missing_zipcode') }, status: :unprocessable_entity
      end
    end
  end
end
