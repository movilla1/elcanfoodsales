# frozen_string_literal: true

class PriceList < ApplicationRecord
  validates :name, presence: true
  validates :valid_through,
    timeliness: {
      on_or_before: -> { Date.current },
      type: :date
    }

  belongs_to :user
  has_many :prices

  enum status: %i[active inactive expired]
end
