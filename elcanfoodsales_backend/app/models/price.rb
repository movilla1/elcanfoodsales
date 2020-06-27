# == Schema Information
#
# Table name: prices
#
#  id            :bigint           not null, primary key
#  price         :float
#  status        :integer
#  valid_until   :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  price_list_id :bigint           not null
#  product_id    :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_prices_on_price_list_id  (price_list_id)
#  index_prices_on_product_id     (product_id)
#  index_prices_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (price_list_id => price_lists.id)
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#
class Price < ApplicationRecord
  belongs_to :product
  belongs_to :user
  belongs_to :price_list

  validates :price, numericality: { greater_than: 0 }

  enum status: { :active => 0, :inactive => 1, :expired => 2 }
end
