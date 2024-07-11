# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    association :user
    name { Faker::Name.name }
    cpf { CPF.generate }
    phone { Faker::PhoneNumber.cell_phone_in_e164[1..11] }
    created_at { Time.zone.now }
    updated_at { Time.zone.now }
  end

  trait :with_address do
    after(:build) do |contact|
      contact.address = build(:address, contact:)
    end
  end
end
