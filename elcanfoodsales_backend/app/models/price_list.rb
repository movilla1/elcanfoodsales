# frozen_string_literal: true

# == Schema Information
#
# Table name: price_lists
#
#  id            :bigint           not null, primary key
#  name          :string
#  status        :integer
#  valid_through :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_price_lists_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class PriceList < ApplicationRecord
  validates :name, presence: true
  validate :valid_through_in_the_future_or_nil

  belongs_to :user
  has_many :prices, dependent: :destroy

  enum status: { :active => 0, :inactive => 1, :expired => 2 }

  before_save :invalidate_or_expire_prices

  scope :valid, -> { where("valid_through >= CURRENT_TIMESTAMP") }

  private

  def valid_through_in_the_future_or_nil
    return true if valid_through.blank?
    return true if (valid_through - Time.current).positive?
    errors.add(:base, I18n.t("api.models.price_list.errors.valid_through_past"))
  end

  def invalidate_or_expire_prices
    if status_changed?
      prices.each do |price|
        case status
        when 'inactive'
          price.inactive!
        when 'expired'
          price.expired!
        end
      end
    end
  end
end
