# frozen_string_literal: true

json.extract! contact, :id, :user_id, :name, :cpf, :phone, :created_at, :updated_at
json.address do
  json.extract!(
    contact.address,
    :id,
    :street,
    :city,
    :uf,
    :zipcode,
    :number,
    :complement,
    :neighborhood,
    :latitude,
    :longitude
  )
end

json.url api_contact_url(contact, format: :json)
