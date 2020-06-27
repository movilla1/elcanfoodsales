# frozen_string_literal: true

# == Schema Information
#
# Table name: purchases
#
#  id         :bigint           not null, primary key
#  date       :date
#  note       :string
#  price      :float
#  quantity   :integer
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Purchase < ApplicationRecord
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true

  belongs_to :product
  belongs_to :supplier

  has_many :stock_histories

  after_create :increase_stocks

  private

  def increase_stocks
    product.update(quantity: product.quantity + quantity)
    StockHistory.create(product_id: product_id, quantity: new_quantity)
  end
end
