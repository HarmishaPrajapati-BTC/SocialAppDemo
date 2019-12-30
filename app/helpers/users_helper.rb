module UsersHelper

  def check_exist_friend_request(user)
    request_sent = Notification.find_by(user_id: user.id, notified_by_id: current_user.id)
  end

  def already_friends(user)
    current_user.friends.include?(user)
  end

  def check_profile_image_attached
    current_user.profile_image.attached? ? current_user.profile_image : 'default_img.jpeg'
  end
end
