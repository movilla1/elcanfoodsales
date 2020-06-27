# == Schema Information
#
# Table name: price_lists
#
#  id            :bigint           not null, primary key
#  name          :string
#  status        :integer
#  valid_through :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_price_lists_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe PriceList, type: :model do
  describe "Validations" do
    before do
      user = FactoryBot.create(:user)
      @price_list = PriceList.new(
        name: "Blabla price 1",
        valid_through: (Date.today + 2.days),
        user_id: user.id,
      )
    end

    it "validates properly" do
      expect(@price_list).to be_valid
    end
    it "won't validate with no name" do
      @price_list.name = nil
      expect(@price_list).to be_invalid
    end
    it "won't validate past dates" do
      @price_list.valid_through = (Date.today - 2.days)
      expect(@price_list).to be_invalid
    end
  end

  describe "Scopes" do
    before do
      user = FactoryBot.create(:user)
      @price_list = PriceList.create(
        name: "Blabla price 1",
        valid_through: (Date.today + 2.days),
        user_id: user.id,
      )
      PriceList.create(
        name: "Blabla price 2",
        valid_through: (Date.today + 2.days),
        user_id: user.id,
      )
    end

    it "Gets only valid price lists" do
      expect(PriceList.valid.first.id).to eq(@price_list.id)
    end
  end

  describe "Functions" do
    before do
      user = FactoryBot.create(:user)
      @price_list = PriceList.create(
        name: "Blabla price 1",
        valid_through: (Date.today + 2.days),
        user_id: user.id,
      )
      @price = FactoryBot.create(:price, price_list_id: @price_list.id, user_id: user.id)
    end

    it "deactivates prices when the price list deactivates" do
      @price_list.status = 'inactive'
      @price_list.save
      expect(@price.reload.inactive?).to eq(true)
    end

    it "expires prices when the list expires" do
      @price_list.status = 'expired'
      @price_list.save
      expect(@price.reload.expired?).to eq(true)
    end
  end
end
