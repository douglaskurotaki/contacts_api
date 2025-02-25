FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    uid { email }
    password { '12345678' }
    password_confirmation { password }

    factory :confirmed_user do
      confirmed_at { Time.zone.now }
    end
  end
end
