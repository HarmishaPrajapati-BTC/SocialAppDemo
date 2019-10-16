class SharePostsController < ApplicationController
  before_action :set_share_post, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @share_post = SharePost.new
    respond_to do |format|
      format.js { render 'new' }
    end
  end

  def edit
    respond_to do |format|
      format.js { render 'edit' }
    end
  end

  def create
    shared_post_id = SharePost.find_by(post_id: share_post_params[:post_id])
    shared_post_user_id = share_post_params[:users].reject(&:empty?)
    if shared_post_id.present?
      shared_post_user_id.each do |user|
        if !shared_post_id.users.include?(user)
          shared_post_id.users.push(user)
        end
        shared_post_id.save
      end
      redirect_to shared_post_id
    else
      @share_post = SharePost.new(share_post_params)
      @share_post.users = share_post_params[:users].reject(&:empty?)
      respond_to do |format|
        if @share_post.save
          format.html { redirect_to @share_post, notice: 'Post Shared successfully.' }
        else
          format.js { render :new }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @share_post.update(share_post_params)
        format.html { redirect_to @share_post, notice: 'Sharing was successfully updated.' }
      else
        format.js { render :edit }
      end
    end
  end

  def destroy
    @share_post.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Sharing was successfully destroyed.' }
    end
  end

  private
    def set_share_post
      @share_post = SharePost.find(params[:id])
    end

    def share_post_params
      params.require(:share_post).permit(:post_id, users: [])
    end
end
