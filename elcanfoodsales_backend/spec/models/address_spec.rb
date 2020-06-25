# frozen_string_literal: true

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
