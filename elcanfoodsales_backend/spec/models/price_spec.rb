# == Schema Information
#
# Table name: prices
#
#  id            :bigint           not null, primary key
#  price         :float
#  status        :integer
#  valid_until   :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  price_list_id :bigint           not null
#  product_id    :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_prices_on_price_list_id  (price_list_id)
#  index_prices_on_product_id     (product_id)
#  index_prices_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (price_list_id => price_lists.id)
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#
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
