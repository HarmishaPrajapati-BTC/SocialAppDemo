class PostPolicy < ApplicationPolicy
  def index?
    allow_all_user?
  end

  def show?
    allow_all_user?
  end

  def new?
    create?
  end

  def create?
    allow_all_user?
  end

  def edit?
    update?
  end

  def update?
    allow_admin? || record.user_id == user.id
  end

  def destroy?
    allow_admin? || record.user_id == user.id
  end

  class Scope < Scope
    def resolve
      if user.has_role? :admin
        scope.all
      else
        scope.where(id: user.post_ids)
      end
    end
  end
end
