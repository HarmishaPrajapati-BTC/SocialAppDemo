module PostsHelper

  def list_current_user_groups
    current_user.groups.order(:name)
  end

  def comment_by_user(comment)
    User.find_by(id: comment.user_id)
  end
end
