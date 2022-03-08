class UsersController < ApplicationController
  before_action :set_user, only: [:follow, :unfollow]

  def index
    @users = User.all
    @users = User.where.not(id: current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @followings = Follow.where(follower: @user)
    @followers = Follow.where(following: @user)
    @feedbacks = @user.feedbacks.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(current_user)
  end

  def follow
    if current_user.follow(@user.id)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  def unfollow
    if current_user.unfollow(@user.id)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render action: :follow }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
