class Search::FollowingsController < ApplicationController

  def index
    @users = current_user.followings
  end
end
