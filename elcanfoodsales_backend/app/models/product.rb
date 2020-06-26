# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :user
  has_many :purchases
  has_many :stock_histories
  has_many :prices
  has_one_attached :image

  enum status: { :active => 0, :obsolete => 1, :inactive => 2 }

  validates :name, presence: true, length: { minimum: 4 }
  validates :quantity, numericality: { greater_or_equal_to: 0 }
end
