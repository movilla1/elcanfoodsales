# frozen_string_literal: true

# == Schema Information
#
# Table name: purchases
#
#  id          :bigint           not null, primary key
#  date        :date
#  note        :string
#  price       :float
#  quantity    :integer
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :bigint           not null
#  supplier_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_purchases_on_product_id   (product_id)
#  index_purchases_on_supplier_id  (supplier_id)
#  index_purchases_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (supplier_id => suppliers.id)
#  fk_rails_...  (user_id => users.id)
#
class Purchase < ApplicationRecord
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  belongs_to :product
  belongs_to :supplier

  has_many :stock_histories

  after_create :update_stocks

  private

  def update_stocks
    product.update!(quantity: product.quantity + quantity)
    StockHistory.create!(product_id: product_id, quantity: quantity, user_id: user_id, operation: "add")
  end
end
