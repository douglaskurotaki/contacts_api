# frozen_string_literal: true

json.extract! contact, :id, :user_id, :name, :cpf, :phone, :address, :latitude, :longitude, :created_at, :updated_at
json.url api_contact_url(contact, format: :json)
