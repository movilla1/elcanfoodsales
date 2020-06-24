# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :user
  has_many :purchases
  has_many :stock_histories

  enum status: %i[active obsolete inactive]
end
