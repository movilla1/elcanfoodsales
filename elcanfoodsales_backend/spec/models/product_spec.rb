# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :string
#  name        :string
#  quantity    :integer
#  size        :string
#  status      :integer
#  weight      :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

# t.string "name"
# t.string "image"
# t.text "description"
# t.string "size"
# t.float "weight"
# t.integer "status"
# t.bigint "user_id"
# t.datetime "created_at", precision: 6, null: false
# t.datetime "updated_at", precision: 6, null: false
# t.integer "quantity"
RSpec.describe Product, type: :model do
  describe "Validations" do
    before do
      usr = FactoryBot.create(:user)
      @prod = Product.new(
        description: "Lorem ipsum sir dolor amet",
        image: "placeholder.png",
        name: "this is a name",
        size: "adult",
        status: 'active',
        quantity: 3,
        user_id: usr.id,
        weight: 10,
      )
    end

    it "validates properly" do
      expect(@prod).to be_valid
    end
    it "fails with no name" do
      @prod.name = nil
      expect(@prod).to be_invalid
    end

    it "fails with no quantity" do
      @prod.quantity = nil
      expect(@prod).to be_invalid
    end

    it "fails for negative quantity" do
      @prod.quantity = -1
      expect(@prod).to be_invalid
    end

    it "fails with no weight" do
      @prod.weight = nil
      expect(@prod).to be_invalid
    end
  end

  describe "scopes" do
    before do
      usr = FactoryBot.create(:user)
      @prod = Product.new(
        description: "Lorem ipsum sir dolor amet",
        image: "placeholder.png",
        name: "this is a name",
        size: "adult",
        status: 'active',
        quantity: 3,
        user_id: usr.id,
        weight: 10,
      )
      @prod2 = Product.new(
        description: "Lorem ipsum sir dolor amet",
        image: "placeholder.png",
        name: "this is a name",
        size: "adult",
        status: 'inactive',
        quantity: 3,
        user_id: usr.id,
        weight: 10,
      )
    end

    it "gets active products only" do
      expect(Product.active).not_to include(@prod2)
    end
  end
end
