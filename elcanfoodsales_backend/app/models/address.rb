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
class Address < ApplicationRecord
  validates :street, presence: true
  validates :city, presence: true
  validates :province, presence: true

  belongs_to :user
end
