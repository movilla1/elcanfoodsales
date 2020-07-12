# == Schema Information
#
# Table name: stock_histories
#
#  id         :bigint           not null, primary key
#  operation  :integer          default("add")
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
require 'rails_helper'

RSpec.describe StockHistory, type: :model do
  pending "This is just to load the model, it's a logging model, no validations or special functions needed"
end
