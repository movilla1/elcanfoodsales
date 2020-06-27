# == Schema Information
#
# Table name: price_lists
#
#  id            :bigint           not null, primary key
#  name          :string
#  status        :integer
#  valid_through :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_price_lists_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :price_list do
    name { Faker::Name.name }
    valid_through { Date.today + 1.year }
    association :user
  end
end
