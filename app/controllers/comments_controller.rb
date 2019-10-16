class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def post_comments
    @post = Post.find(params[:id])
    @comments = @post.comments.order('created_at DESC')
  end

  def show
  end

  def new
    @comment = Comment.new
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
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(comment_params[:post_id]), notice: 'Comment was successfully created.' }
      else
        format.js { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
      else
        format.js { render :edit }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Comment was successfully destroyed.' }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:comment_text, :post_id, :user_id)
    end
end
