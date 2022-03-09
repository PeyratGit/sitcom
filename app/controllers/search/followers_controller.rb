class Search::FollowersController < ApplicationController

  def index
    @followers = current_user.followers
  end
end
