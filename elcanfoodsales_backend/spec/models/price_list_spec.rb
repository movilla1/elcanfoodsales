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
end
