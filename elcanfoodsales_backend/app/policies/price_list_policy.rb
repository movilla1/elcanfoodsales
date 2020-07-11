class PriceListPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    admin?
  end
end
