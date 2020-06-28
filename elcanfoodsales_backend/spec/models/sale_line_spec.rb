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
require 'rails_helper'

RSpec.describe SaleLine, type: :model do
  describe "Validations" do
    before do
      prod = FactoryBot.create(:product)
      customer = FactoryBot.create(:customer)
      sale = FactoryBot.create(:sale, user_id: prod.user_id, total: 0, customer_id: customer.id)
      @sale_line = SaleLine.new(
        quantity: 1,
        status: :new_sale,
        subtotal: 2.5,
        product_id: prod.id,
        sale_id: sale.id,
        user_id: prod.user_id,
      )
    end

    it "won't validate zero quantity" do
      @sale_line.quantity = 0
      expect(@sale_line).to be_invalid
    end

    it "won't validate negative subtotal" do
      @sale_line.subtotal = -1
      expect(@sale_line).to be_invalid
    end

    it "validates properly" do
      expect(@sale_line).to be_valid
    end
  end

  describe "Functions" do
    before do
      @prod = FactoryBot.create(:product)
      customer = FactoryBot.create(:customer)
      sale = FactoryBot.create(:sale, user_id: @prod.user_id, total: 0, customer_id: customer.id)
      @sale_line = SaleLine.new(
        quantity: 1,
        status: :new_sale,
        subtotal: 2.5,
        product_id: @prod.id,
        sale_id: sale.id,
        user_id: @prod.user_id,
      )
    end
    it "decrements product stock" do
      @sale_line.decrease_stock
      expect{ @prod.reload }.to change(@prod, :quantity).by(-1)
    end
  end
end
