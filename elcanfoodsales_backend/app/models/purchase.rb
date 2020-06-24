# frozen_string_literal: true

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
