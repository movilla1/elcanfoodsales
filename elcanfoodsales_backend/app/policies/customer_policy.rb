class CustomerPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    @user.present?
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
end
