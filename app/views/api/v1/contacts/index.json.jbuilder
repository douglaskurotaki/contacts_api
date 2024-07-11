# frozen_string_literal: true

json.set! :contacts do
  json.array! @contacts, partial: 'api/v1/contacts/contact', as: :contact
end

json.pagination pagination_meta(@contacts)
