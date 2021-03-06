class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @q = policy_scope(User).ransack(params[:q])
    @users = @q.result.order(updated_at: :DESC).page(params[:page]).per(8)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def find_friends
    @q = User.where.not(id: current_user.id).ransack(params[:q])
    @users = @q.result
    authorize @users
  end

  def friend_list
    session[:conversations] ||= []
    @friends = current_user.friends.page(params[:page]).per(5)
    @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
  end

  def account
    @user = current_user
    authorize @user
  end

  def create_notifications
    return if params[:id] == current_user.id
    request_sent = Notification.find_by(user_id: params[:id], notified_by_id: current_user.id)
    if !request_sent.present?
      Notification.create(user_id: params[:id], notified_by_id: current_user.id, notice_type: 'New Friend Request')
    end
    send_friend_request
    redirect_to request.referrer
  end

  def send_friend_request
    user = User.find(params[:id])
    current_user.friend_request(user) if !current_user.friends.include?(user)
  end

  def accept_friend_request
    notification = Notification.find(params[:id])
    user_id = notification.notified_by_id
    user = User.find(user_id)
    current_user.accept_request(user)
    redirect_to request.referrer
  end

  def remove_from_friends
    notification = Notification.find(params[:id])
    user_id = notification.notified_by_id
    user = User.find(user_id)
    if current_user.friends.include?(user)
      current_user.friends.delete(user)
      notification.delete
    end
    redirect_to request.referrer
  end

  def reject_friend_request
    notification = Notification.find(params[:id])
    user_id = notification.notified_by_id
    user = User.find(user_id)
    current_user.decline_request(user)
    if current_user.friends.include?(user)
      current_user.friends.delete(user)
    end
    notification.delete
    redirect_to request.referrer
  end

  def delete_image_attachment
    @image = ActiveStorage::Attachment.find_by(id: params[:profile_image_id])
    @image.purge
    flash[:notice] = t('flash_notice.destroy.success', resource: 'Image')
    redirect_to edit_user_path(id: params[:id])
  end

  private
    def set_user
      @user = User.friendly.find(params[:id])
      authorize @user
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :contact_number, :address, :profile_image)
    end
end
