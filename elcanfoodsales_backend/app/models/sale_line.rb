# == Schema Information
#
# Table name: sale_lines
#
#  id         :bigint           not null, primary key
#  quantity   :float
#  status     :integer
#  subtotal   :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  sale_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_sale_lines_on_product_id  (product_id)
#  index_sale_lines_on_sale_id     (sale_id)
#  index_sale_lines_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (sale_id => sales.id)
#  fk_rails_...  (user_id => users.id)
#
class SaleLine < ApplicationRecord
  belongs_to :product
  belongs_to :sale

  enum status: { :new => 0, :completed => 1, :paid => 2, :refunded => 3, :cancelled => 4 }
  after_create :decrease_stock

  private

  def decrease_stock
    product.update!(quantity: product.quantity - quantity)
  end
end
