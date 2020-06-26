FactoryBot.define do
  factory :product do
    name { Faker::Food.fruits }
    description { Faker::Food.description }
    size { Faker::Number.number(digits: 2) }
    weight { Faker::Number.number(digits: 2) }
    quantity { Faker::Number.number(digits: 2) }
    association :user
  end
end
