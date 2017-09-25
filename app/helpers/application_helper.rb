module ApplicationHelper

  def user_privileged?(user, object)
    return true if user.admin?

    if object.is_a?(User)
      user == object
    else
      user == object.user
    end
  end
end
