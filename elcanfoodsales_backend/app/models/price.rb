class Price < ApplicationRecord
  belongs_to :product
  belongs_to :user
  belongs_to :price_list

  validates :price, numericality: { greater_than: 0 }

  enum status: { :active => 0, :inactive => 1, :expired => 2 }
end
