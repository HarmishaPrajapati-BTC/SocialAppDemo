class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = policy_scope(Group).page(params[:page]).per(5)
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
    authorize @group
    @group.users = User.where(id: params[:group][:user_ids])
    if @group.new_record?
      if current_user != 'admin'
        current_user.add_role :group_admin
      end
    end
    respond_to do |format|
      if @group.save
        # User.invite!(email: "yuyuuhjm@gmail.com")
        format.html { render :show, notice: 'Group was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
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
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_group
      @group = Group.find(params[:id])
      authorize @group
    end

    def group_params
      params.require(:group).permit(:name, user_ids: [])
    end
end
