# == Schema Information
#
# Table name: purchases
#
#  id          :bigint           not null, primary key
#  date        :date
#  note        :string
#  price       :float
#  quantity    :integer
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :bigint           not null
#  supplier_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_purchases_on_product_id   (product_id)
#  index_purchases_on_supplier_id  (supplier_id)
#  index_purchases_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (supplier_id => suppliers.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe "Validations" do
    before do
      @usr = FactoryBot.create(:user)
      @product = FactoryBot.create(:product)
      supplier = FactoryBot.create(:supplier)
      @purchase = Purchase.new(
        note: 'Lorem ipsum sir dolor amet pax domum',
        date: Date.today,
        price: 3.5,
        quantity: 25,
        status: 'active',
        product: @product,
        user_id: @usr.id,
        supplier_id: supplier.id,
      )
    end

    it "fails with no price" do
      @purchase.price = nil
      expect(@purchase).to be_invalid
    end

    it "fails for negative qty" do
      @purchase.quantity = -1
      expect(@purchase).to be_invalid
    end

    it "fails with no quantity" do
      @purchase.quantity = nil
      expect(@purchase).to be_invalid
    end

    it "validates properly" do
      expect(@purchase).to be_valid
    end
  end

  describe "functions" do
    before do
      @usr = FactoryBot.create(:user)
      @product = FactoryBot.create(:product)
      @product.save!
      supplier = FactoryBot.create(:supplier)
      @purchase = Purchase.new(
        note: 'Lorem ipsum sir dolor amet pax domum',
        price: 3.5,
        quantity: 25,
        status: 'active',
        date: Date.today,
        supplier_id: supplier.id,
        product_id: @product.id,
        user_id: @usr.id,
      )
    end

    it "updates stock after new purchase" do
      @purchase.save!
      expect{ @product.reload }.to change(@product, :quantity).by(@purchase.quantity)
    end

    it "creates a new history record on purchase" do
      expect{ @purchase.save! }.to change(StockHistory, :count).by(1)
    end

  end
end
