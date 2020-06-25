# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'Validations' do
    before do
      usr = FactoryBot.create(:user)
      @customer = Customer.new(
        name: 'John Constantine',
        birthday: Date.today,
        phone: '123-1234',
        email: 'me@here.com',
        pet_name: 'Doggy',
        pet_type: :dog,
        user_id: usr.id
      )
    end
    it 'wont validate without email and phone' do
      @customer.phone = nil
      @customer.email = nil
      expect(@customer).to be_invalid
    end
    it "won't validate without name" do
      @customer.name = nil
      expect(@customer).to be_invalid
    end

    it "won't validate with no pet type" do
      @customer.pet_type = nil
      expect(@customer).to be_invalid
    end

    it "validates complete records" do
      expect(@customer).to be_valid
    end
  end
end
