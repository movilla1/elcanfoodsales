# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  birthday   :date
#  email      :string
#  name       :string
#  pet_name   :string
#  pet_type   :integer
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_customers_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Customer < ApplicationRecord
  validates :name, presence: true
  validates :pet_type, presence: true
  validate :phone_or_email

  belongs_to :user
  has_many :sales

  enum pet_type: { :dog => 0, :cat => 1, :bird => 2, :reptile => 3, :rodent => 4, :fish => 5 }

  private

  def phone_or_email
    phone_or_email_present = phone.present? || email.present?
    return true if phone_or_email_present
    errors.add(:base, I18n.t("api.models.customer.errors.email_or_phone"))
  end
end
