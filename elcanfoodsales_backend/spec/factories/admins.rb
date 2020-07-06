FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name + Faker::Name.middle_name }
    last_name { Faker::Name.last_name }
    password { Faker::FunnyName.two_word_name }
    type { "Admin" }
    confirmed_at { DateTime.now }
  end
end
