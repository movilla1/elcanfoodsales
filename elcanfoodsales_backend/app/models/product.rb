class Product < ApplicationRecord
  belongs_to :user
  has_many :purchases
  has_many :stocks

  enum status: [:active, :obsolete, :inactive]
end
