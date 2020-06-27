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
require 'rails_helper'

RSpec.describe Sale, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
