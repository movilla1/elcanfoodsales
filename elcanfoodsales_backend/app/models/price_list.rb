class PriceList < ApplicationRecord
  belongs_to :user
  has_many :prices

  enum status: %i[active inactive]
end
