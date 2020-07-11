# Default policy will allow users to see and admin to update or destroy
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

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

  def show?
    @user.present?
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end

  private

  def admin?
    @user.type == "Admin"
  end
end
