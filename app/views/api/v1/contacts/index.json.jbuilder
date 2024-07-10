# frozen_string_literal: true

json.array! @contacts, partial: 'api/v1/contacts/contact', as: :contact
