require 'rails_helper'

RSpec.describe Price, type: :model do
  describe "Validations" do
    before do
      pl = FactoryBot.create(:price_list)
      prod = FactoryBot.create(:product)
      @price = Price.new(
        user_id: pl.user_id,
        price_list_id: pl.id,
        product_id: prod.id,
        price: 1.5
      )
    end

    it "Validates a price properly" do
      expect(@price).to be_valid
    end

    it "won't validate with no price" do
      @price.price = nil
      expect(@price).to be_invalid
    end

    it "Won't validate with negative price" do
      @price.price = -1
      expect(@price).to be_invalid
    end
  end

  describe "functions" do
    before do
      @pl = FactoryBot.create(:price_list)
      @prod = FactoryBot.create(:product)
      @price = Price.create!(
        user_id: @pl.user_id,
        price_list_id: @pl.id,
        product_id: @prod.id,
        price: 1.5,
        status: :active
      )
    end

    it "product has one active price" do
      expect(@prod.prices.active.first).to eq(@price)
    end
  end
end
