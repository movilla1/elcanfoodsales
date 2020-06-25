class Customer < ApplicationRecord
  validates :name, presence: true
  belongs_to :user

  has_many :sales
end
