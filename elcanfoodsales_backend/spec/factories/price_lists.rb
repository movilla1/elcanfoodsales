FactoryBot.define do
  factory :price_list do
    name { Faker::Name.name }
    valid_through { Date.today + 1.year }
    association :user
  end
end
