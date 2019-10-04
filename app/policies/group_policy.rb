class GroupPolicy < ApplicationPolicy
  def index?
    allow_admin? && allow_group_admin?
  end

  def new?
    create?
  end

  def create?
    allow_all_user? && allow_group_admin?
  end

  def edit?
    update?
  end

  def update?
    allow_admin? && allow_group_admin?
  end

  def destroy?
    allow_admin? && allow_group_admin?
  end

  class Scope < Scope
    def resolve
      if user.has_role? :admin
        scope.all
      else
        binding.pry
        scope.where(id: user.group_ids)
      end
    end
  end
end
