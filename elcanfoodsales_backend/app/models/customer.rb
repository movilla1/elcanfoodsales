class Customer < ApplicationRecord
  validates :name, presence: true
  validates :pet_type, presence: true
  validate :phone_or_email

  belongs_to :user
  has_many :sales

  enum pet_type: %i[dog cat bird reptile rodent fish]

  private

  def phone_or_email
    unless phone.present? || email.present?
      errors.add(:base, I18n.t("api.models.customer.errors.email_or_phone"))
    end
  end
end
