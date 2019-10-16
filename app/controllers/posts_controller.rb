class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.page(params[:page]).per(5)
    authorize @posts
  end

  def show
  end

  def new
    @post = Post.new
    @comment = Comment.new(post_id: params[:post_id])
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save!
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def delete_image_attachment
    @image = ActiveStorage::Attachment.find_by(id: params[:image_id])
    @image.purge
    flash[:notice] = t('flash_notice.destroy.success', resource: 'Image')
    redirect_to edit_post_path(id: params[:id])
  end

  def liked_by_user
    user_name = []
    @post = Post.find(params[:post_id])
    @post.likes.each do |user|
      user_name << User.find_by(id: user.user_id)
    end
    @users = user_name
  end

  def post_share
    @post = Post.find(params[:post_id])
    @share_posts = @post.share_posts.each do |share_post|
                      share_posts = share_post.users
                    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
      authorize @post
    end

    def post_params
      params.require(:post).permit(:name, :post_type, :content, :user_id, :group_id, :image)
    end
end
