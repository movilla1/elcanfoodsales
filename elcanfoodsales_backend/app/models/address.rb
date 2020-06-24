class Address < ApplicationRecord
  validates :street, presence: true
  validates :city, presence: true
  validates :province, presence: true

  belongs_to :user
end
