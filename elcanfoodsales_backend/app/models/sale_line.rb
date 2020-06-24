class SaleLine < ApplicationRecord
  belongs_to :product
  belongs_to :sale

  after_create :decrease_stock

  private

  def decrease_stock
    product.update!(quantity: product.quantity - quantity)
  end
end
