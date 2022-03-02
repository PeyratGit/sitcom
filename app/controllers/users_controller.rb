class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @following = Follow.where(follower: @user)
    @followers = Follow.where(following: @user)
  end
end
