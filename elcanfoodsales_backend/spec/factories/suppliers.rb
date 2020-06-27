# == Schema Information
#
# Table name: suppliers
#
#  id           :bigint           not null, primary key
#  address      :string
#  contact_name :string
#  date_start   :date
#  email        :string
#  name         :string
#  phone        :string
#  status       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_suppliers_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :supplier do
    contact_name { Faker::Name.name }
    address { Faker::Address.street_address }
    date_start { Date.today }
    email { Faker::Internet.email }
    name { Faker::Name.name }
    phone { "+1-244-2133" }
    status { "active" }
    association :user
  end
end
