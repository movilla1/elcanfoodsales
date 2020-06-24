class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :confirmable, :trackable
  validates :first_name, presence: true, length: { minimum: 3 }
  validates :last_name, presence: true, length: { minimum: 3 }

  has_many :addresses
  has_many :products
  has_many :customers
  has_many :stocks

end
