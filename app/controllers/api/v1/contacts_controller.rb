# frozen_string_literal: true

module Api
  module V1
    class ContactsController < ApplicationController
      before_action :authenticate_api_user!
      before_action :set_contact, only: %i[show update destroy]

      def index
        @contacts = ContactRepository.call(
          user: current_api_user,
          filter_value: params[:filter_value],
          order: params[:order] || 'name',
          page: params[:page] || 1,
          per_page: params[:per_page] || 10
        )
      end

      def show; end

      def create
        @contact = current_api_user.contacts.new(contact_params)

        if @contact.save
          render :show, status: :created, location: api_contacts_path(@contact)
        else
          render json: @contact.errors, status: :unprocessable_entity
        end
      end

      def update
        if @contact.update(contact_params)
          render :show, status: :ok, location: api_contact_path(@contact)
        else
          render json: @contact.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @contact.destroy!
      end

      private

      def set_contact
        @contact = current_api_user.contacts.find(params[:id])
      end

      def contact_params
        params.require(:contact).permit(:user_id, :name, :cpf, :phone,
                                        address_attributes: %i[
                                          street
                                          city
                                          uf
                                          city
                                          zipcode
                                          number
                                          complement
                                          neighborhood
                                        ])
      end
    end
  end
end
