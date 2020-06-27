# == Schema Information
#
# Table name: sale_lines
#
#  id         :bigint           not null, primary key
#  quantity   :float
#  status     :integer
#  subtotal   :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  sale_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_sale_lines_on_product_id  (product_id)
#  index_sale_lines_on_sale_id     (sale_id)
#  index_sale_lines_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (sale_id => sales.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :sale_line do
    quantity { rand(10) }
    status { 0 }
    subtotal { rand(35) }
    association :user
    association :product
    association :sale
  end
end
