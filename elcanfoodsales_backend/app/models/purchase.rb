class Purchase < ApplicationRecord
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true

  belongs_to :product
end
