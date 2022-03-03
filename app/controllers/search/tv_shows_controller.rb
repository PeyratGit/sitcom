class Search::TvShowsController < ApplicationController
  def index
    if params[:query].present?
      @tv_shows = TvShow.where("title ILIKE ?", "%#{params[:query]}%")
    else
      @tv_shows = TvShow.all
    end
  end
end
