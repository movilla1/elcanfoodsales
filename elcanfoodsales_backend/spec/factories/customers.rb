FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    pet_name { Faker::Types.rb_string }
    pet_type { Faker::Types.rb_string }
    user
  end
end
