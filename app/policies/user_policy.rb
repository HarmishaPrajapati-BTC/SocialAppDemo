class UserPolicy < ApplicationPolicy
  def index?
    allow_admin?
  end

  def show?
    allow_all_user?
  end

  def new?
    create?
  end

  def create?
    allow_admin?
  end

  def edit?
    update?
  end

  def update?
    allow_admin? || record.id == user.id
  end

  def destroy?
    allow_admin? || record.id == user.id
  end

  def find_friends?
    allow_all_user?
  end

  def account?
    record.id == user.id
  end

  class Scope < Scope
    def resolve
      if user.has_role? :admin
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
end
