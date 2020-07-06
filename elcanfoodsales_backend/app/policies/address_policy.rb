class AddressPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    @user.present?
  end

  def destroy?
    @user.present?
  end

  def update?
    if @user.id == @record.id || admin?
      return true
    end
    false
  end

  def index?
    @user.present?
  end
end
