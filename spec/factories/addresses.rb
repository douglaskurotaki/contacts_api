# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    association :contact
    city { Faker::Address.city }
    street { Faker::Address.street_name }
    neighborhood { Faker::Address.community }
    number { Faker::Address.building_number }
    zipcode { Faker::Address.zip_code }
    uf { Faker::Address.state_abbr }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
