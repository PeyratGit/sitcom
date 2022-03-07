class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @following = Follow.where(follower: @user)
    @followers = Follow.where(following: @user)
    @feedbacks = @user.feedbacks.order(created_at: :desc)
    @superlikes = @user.feedbacks.where(status: "Superlike")
    @likes = @user.feedbacks.where(status: "Like")
    @dislikes = @user.feedbacks.where(status: "Dislike")
  end
end
