# == Schema Information
#
# Table name: stock_histories
#
#  id         :bigint           not null, primary key
#  operation  :integer          default(0)
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_stock_histories_on_product_id  (product_id)
#  index_stock_histories_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#
class StockHistory < ApplicationRecord
  belongs_to :product
  belongs_to :user

  enum operations: { :add => 0, :remove => 1, :reconcile => 2 }
end
