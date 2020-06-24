class Product < ApplicationRecord
  belongs_to :user
  has_many :purchases

  enum status: [:active, :obsolete, :inactive]
end
