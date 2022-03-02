class TvShowsController < ApplicationController
  def index
    @tv_shows = TvShow.all
  end

  def show
    @tv_show = TvShow.find(params[:id])
  end
end
