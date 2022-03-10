class Search::FollowersController < ApplicationController

  def index
    @users = current_user.followers
  end
end
