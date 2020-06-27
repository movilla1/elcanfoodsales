# == Schema Information
#
# Table name: sales
#
#  id          :bigint           not null, primary key
#  notes       :string
#  total       :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_sales_on_customer_id  (customer_id)
#  index_sales_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (user_id => users.id)
#
class Sale < ApplicationRecord
  belongs_to :customer
  belongs_to :user

  has_many :sale_lines
  has_many :products, through: :sale_lines
end
