# == Schema Information
#
# Table name: addresses
#
#  id          :bigint           not null, primary key
#  appartment  :string
#  city        :string
#  country     :string
#  number      :string
#  postal_code :string
#  province    :string
#  street      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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
