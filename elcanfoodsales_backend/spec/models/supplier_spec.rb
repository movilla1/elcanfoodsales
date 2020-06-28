# == Schema Information
#
# Table name: suppliers
#
#  id           :bigint           not null, primary key
#  address      :string
#  contact_name :string
#  date_start   :date
#  email        :string
#  name         :string
#  phone        :string
#  status       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_suppliers_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe "Validations" do
    before do
      usr = FactoryBot.create(:user)
      @supplier = Supplier.new(
        address: '123 Blabla street',
        contact_name: 'Simon Garfunkel',
        date_start: Date.today,
        email: 'soundsofsilence@simonhatesgarfunkel.com',
        name: 'Sounds of silence',
        phone: '3333-222-4444',
        status: 'active',
        user_id: usr.id,
      )
    end

    it "won't validate supplier with no name" do
      @supplier.name = nil
      expect(@supplier).to be_invalid
    end

    it "won't validate with no email and phone" do
      @supplier.email = nil
      @supplier.phone = nil
      expect(@supplier).to be_invalid
    end

    it "won't validate without contact name" do
      @supplier.contact_name = nil
      expect(@supplier).to be_invalid
    end

    it "won't validate without address" do
      @supplier.address = nil
      expect(@supplier).to be_invalid
    end

    it "validates properly with just phone" do
      @supplier.email = nil
      expect(@supplier).to be_valid
    end

    it "validates properly with just email" do
      @supplier.phone = nil
      expect(@supplier).to be_valid
    end
  end
end
