class PriceListPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    admin?
  end

  def destroy?
    admin?
  end

  def update?
    admin?
  end

  def index?
    @user.present?
  end

  def show?
    @user.present?
  end
end
