class VideoPolicy < ApplicationPolicy
  def index?
    user.admin? || user.staff?
  end

  def show?
    user.admin? || user.staff?
  end

  def serve_video?
    user.admin? || user.staff?
  end

  def create?
    user.admin? || user.staff?
  end

  def update?
    user.admin? || (user.staff? && record.user_id == user.id)
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end
