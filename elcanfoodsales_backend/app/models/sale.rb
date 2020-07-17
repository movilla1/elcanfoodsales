# == Schema Information
#
# Table name: sales
#
#  id          :bigint           not null, primary key
#  notes       :string
#  status      :integer
#  total       :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_sales_on_customer_id  (customer_id)
#  index_sales_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (user_id => users.id)
#
class Sale < ApplicationRecord
  belongs_to :customer
  belongs_to :user

  has_many :sale_lines
  has_many :products, through: :sale_lines
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true
  validates :customer_id, presence: true
  enum status: { :new_sale => 0, :completed => 1, :paid => 2, :refunded => 3, :cancelled => 4 }

  before_save :update_totals_if_completed
  after_save :discount_stock_if_paid

  private

  def update_totals_if_completed
    if status_changed? && completed?
      self.total = 0
      sale_lines.each do |sl|
        self.total += sl.subtotal
      end
    end
  end

  def discount_stock_if_paid
    return unless paid?
    sale_lines.each do |sl|
      sl.decrease_stock
    end
  end
end
