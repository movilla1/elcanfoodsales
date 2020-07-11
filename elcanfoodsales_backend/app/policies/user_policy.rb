class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def create?
    admin?
  end

  def update?
    if @user.id == @record.id || admin?
      return true
    end
    false
  end

  def index?
    admin?
  end
end
