class Sale < ApplicationRecord
  belongs_to :customer
  belongs_to :user

  has_many :sale_lines
  has_many :products, through: :sale_lines
end
