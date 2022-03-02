class Swipe::TvShowsController < ApplicationController
  def index
    @user = current_user
    @tv_shows = TvShow.all
  end
end
