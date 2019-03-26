class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_admin

  def index
    if current_user.is_admin?
      @users = User.all
    else
      @users = current_user.team_members
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to :users
    else
      render :edit
    end
  end
  
  def destroy
    if @user.destroy
      flash[:notice] = "User: #{@user.fullname} was successfully deleted"
      redirect_to users_path
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:fullname, :email, :is_admin, :team_leader_id, :password)
    end
end
