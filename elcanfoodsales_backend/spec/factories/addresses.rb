FactoryBot.define do
  factory :address do
    city { Faker::Address.city }
    street { Faker::Address.street_name }
    appartment { Faker::Address.secondary_address }
    number { 1234 }
    province { Faker::Address.state }
    postal_code { Faker::Address.postcode }
    country { Faker::Address.country }
  end
end
