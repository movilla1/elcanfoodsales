class Supplier < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :addresses, presence: true, length: {minimum: 5}
  validates :email, presence: true
  validates :contact_name, presence: true
  enum status: %i[active banned closed inactive]

  belongs_to :user

  has_many :products
end
