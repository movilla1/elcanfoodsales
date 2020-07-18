# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  type                   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

# t.string "email", default: "", null: false
# t.string "encrypted_password", default: "", null: false
# t.string "first_name"
# t.string "last_name"
# t.string "type"
RSpec.describe User, type: :model do
  describe "validations" do
    before do
      @usr = User.new(
        email: "test@here.com",
        password: "herepass123",
        first_name: "Tester",
        last_name: "America",
        type: "User"
      )
    end
    it "invalid with no email" do
      @usr.email = nil
      expect(@usr).to be_invalid
    end

    it "invalid without password" do
      @usr.password = nil
      expect(@usr).to be_invalid
    end

    it "fails with wrong email" do
      @usr.email = "myemail.At.is-fake.com"
      expect(@usr).to be_invalid
    end

    it "Fails with existing email" do
      User.create(
        email: "test@here.com",
        password: "herepass124",
        first_name: "Tester2",
        last_name: "America2",
        type: "User"
      )
      expect(@usr.save).to be(false)
    end
  end

  describe "Scopes" do
    before do
      @usr = User.create!(
        email: "test@here.com",
        password: "herepass123",
        first_name: "Tester",
        last_name: "America",
        type: "User"
      )
      @usr2 = User.create!(
        email: "test2@here.com",
        password: "herepass123",
        first_name: "Tester",
        last_name: "America",
        type: 'Admin'
      )
    end

    it "only gets admins" do
      expect(User.admins).to include(@usr2)
      expect(User.admins).not_to include(@usr)
    end
  end

end
