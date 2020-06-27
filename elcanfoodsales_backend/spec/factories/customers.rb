# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  birthday   :date
#  email      :string
#  name       :string
#  pet_name   :string
#  pet_type   :integer
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_customers_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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
