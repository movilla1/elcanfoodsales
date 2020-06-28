# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :string
#  name        :string
#  quantity    :integer
#  size        :string
#  status      :integer
#  weight      :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :product do
    name { Faker::Food.vegetables + Faker::Food.fruits }
    description { Faker::Food.description }
    size { Faker::Number.number(digits: 2) }
    weight { Faker::Number.number(digits: 2) }
    quantity { 3 + Faker::Number.number(digits: 3) }
    association :user
  end
end
