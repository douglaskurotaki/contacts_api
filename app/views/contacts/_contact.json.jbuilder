json.extract! contact, :id, :user_id, :name, :cpf, :phone, :address, :latitude, :longitude, :created_at, :updated_at
json.url contact_url(contact, format: :json)
