# == Schema Information
#
# Table name: suppliers
#
#  id           :bigint           not null, primary key
#  contact_name :string
#  date_start   :date
#  email        :string
#  name         :string
#  phone        :string
#  status       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Supplier < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :addresses, presence: true, length: {minimum: 5}
  validates :email, presence: true
  validates :contact_name, presence: true
  enum status: %i[active banned closed inactive]

  belongs_to :user

  has_many :products
end
