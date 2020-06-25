FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { Faker::FunnyName.two_word_name }
    type { "User" }
    confirmed_at { DateTime.now }
  end
end
