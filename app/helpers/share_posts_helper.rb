module SharePostsHelper

  def shared_with_user(share_post)
    user_name = []
    @user = share_post.users
    @user.each do |user_id|
      user_name << User.find_by(id: user_id)
    end
    @users = user_name
  end
end
