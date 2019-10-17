class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.page(params[:page]).per(5)
    authorize @groups
  end

  def show
  end

  def new
    @group = Group.new
    authorize @group
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    if @group.new_record?
      if current_user != 'admin' && (current_user.has_role? :member)
        current_user.add_role :group_admin
        @group.user_id = current_user.id
      end
    end
    authorize @group
    @group.users = User.where(id: params[:group][:user_ids])
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    authorize @group
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @group.destroy
    authorize @group
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join_group
    @group = Group.find params[:id]
    @group.users.each do |user|
      if user != current_user && !@group.users.include?(current_user)
        @group.users << current_user
      end
    end
    redirect_to request.referrer
  end

  def leave_group
    @group = Group.find params[:id]
    @group.users.each do |user|
      if user == current_user
        @group.users.delete(current_user)
      end
    end
    redirect_to request.referrer
  end

  def your_groups
    @groups = Group.where(user_id: current_user.id)
  end

  private
    def set_group
      @group = Group.find(params[:id])
      authorize @group
    end

    def group_params
      params.require(:group).permit(:name, :user_id, :group_type, user_ids: [])
    end
end
