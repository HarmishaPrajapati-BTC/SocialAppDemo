module NotificationsHelper
  def notification_from_user(notification)
    notification_id = notification.notified_by_id
    user_name = User.find(notification_id).first_name
  end

  def find_shared_post(notification)
    post_id = notification.post_id
    post = Post.find_by(id: post_id)
    post_path(post.id)
  end

  def find_user(notification)
    user_id = notification.notified_by_id
    user = User.find(user_id)
    user_path(user)
  end

  def check_presence_of_notification
    notification_present = current_user.notifications.order('created_at DESC')
  end

  def notification_count
    check_presence_of_notification.where(read: false).count
  end

  def display_limited_notification
    check_presence_of_notification.where(read: false).limit(2)
  end

  def check_friend_request_status(notification)
    user_id = notification.notified_by_id
    user = User.find(user_id)
    friends = current_user.friends_with?(user)
  end
end
