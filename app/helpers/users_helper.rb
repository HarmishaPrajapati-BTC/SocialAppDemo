module UsersHelper

  def check_exist_friend_request(user)
    request_sent = Notification.find_by(user_id: user.id, notified_by_id: current_user.id)
  end
end
