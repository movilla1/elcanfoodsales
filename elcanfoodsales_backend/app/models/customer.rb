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
