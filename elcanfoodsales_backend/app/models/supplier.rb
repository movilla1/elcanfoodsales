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
class Supplier < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :address, presence: true, length: { minimum: 5 }
  validates :email, presence: true
  validates :contact_name, presence: true
  enum status: { :active => 0, :banned => 1, :closed => 2, :inactive => 3 }

  belongs_to :user

  has_many :products
end
