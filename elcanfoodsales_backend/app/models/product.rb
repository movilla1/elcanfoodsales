# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :string
#  name        :string
#  quantity    :integer
#  size        :string
#  status      :integer
#  weight      :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Product < ApplicationRecord
  belongs_to :user
  has_many :purchases
  has_many :stock_histories
  has_many :prices
  has_one_attached :image

  enum status: { :active => 0, :obsolete => 1, :inactive => 2 }

  validates :name, presence: true, length: { minimum: 4 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :weight, presence: true, numericality: { greater_than: 0 }

  def decrease_stock(qty)
    self.quantity -= qty
    save!
  end
end
