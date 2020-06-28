# == Schema Information
#
# Table name: sales
#
#  id          :bigint           not null, primary key
#  notes       :string
#  status      :integer
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
  describe "Validations" do
    before do
      customer = FactoryBot.create(:customer)
      @user = FactoryBot.create(:user)
      @sale = Sale.new(
        notes: "Lorem impsum sir dolor amet brava deus et domum",
        total: 0,
        customer_id: customer.id,
        user_id: @user.id
      )
    end

    it "fails to save without customer" do
      @sale.customer_id = nil
      expect(@sale).to be_invalid
    end

    it "fails to save with negative totals" do
      @sale.total = -1
      expect(@sale).to be_invalid
    end
  end

  describe "Functions" do
    before do
      customer = FactoryBot.create(:customer)
      @user = FactoryBot.create(:user)
      @product = FactoryBot.create(:product, user_id: @user.id)
      @sale = Sale.create(
        notes: "Lorem impsum sir dolor amet brava deus et domum",
        total: 0,
        customer_id: customer.id,
        user_id: @user.id
      )
      @sale_line = FactoryBot.create(:sale_line, sale_id: @sale.id, user_id: @user.id, product_id: @product.id)
      @sale_line2 = FactoryBot.create(:sale_line, sale_id: @sale.id, user_id: @user.id)
      @original_qty = @product.quantity
    end

    it "calculates the total sale" do
      @sale.status = "completed"
      expect { @sale.save! }.to change(@sale, :total).by(@sale_line.subtotal + @sale_line2.subtotal)
    end

    it "Decrement stock when paid" do
      @sale.status = "paid"
      @sale.save!
      expect(@product.reload.quantity).to eq(@original_qty - @sale_line.quantity)
    end
  end
end
