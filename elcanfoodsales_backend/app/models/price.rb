class Price < ApplicationRecord
  belongs_to :product
  belongs_to :user
  belongs_to :price_list
  
end
