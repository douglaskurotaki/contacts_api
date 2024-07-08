module Api
  module V1
    class ContactsController < ApplicationController
      before_action :set_contact, only: %i[show update destroy]

      def index
        @contacts = Contact.all
      end

      def show
      end

      def create
        @contact = Contact.new(contact_params)

        if @contact.save
          render :show, status: :created, location: @contact
        else
          render json: @contact.errors, status: :unprocessable_entity
        end
      end

      def update
        if @contact.update(contact_params)
          render :show, status: :ok, location: @contact
        else
          render json: @contact.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @contact.destroy!
      end

      private

      def set_contact
        @contact = Contact.find(params[:id])
      end

      def contact_params
        params.require(:contact).permit(:user_id, :name, :cpf, :phone, :address, :latitude, :longitude)
      end
    end
  end
end
