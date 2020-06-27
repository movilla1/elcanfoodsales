# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id          :bigint           not null, primary key
#  appartment  :string
#  city        :string
#  country     :string
#  number      :string
#  postal_code :string
#  province    :string
#  street      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'Validations' do
    before do
      @user = FactoryBot.create(:user)
      @address = Address.new(
        street: 'testing street',
        number: '123',
        city: 'Cordoba',
        province: 'Cordoba',
        country: 'Argentina',
        user_id: @user.id
      )
    end

    it "won't store without street" do
      @address.street = nil
      expect(@address).to be_invalid
    end

    it "won't store without city" do
      @address.city = nil
      expect(@address).to be_invalid
    end

    it "won't store without street" do
      @address.province = nil
      expect(@address).to be_invalid
    end

    it "works properly" do
      expect(@address).to be_valid
    end
  end
end
