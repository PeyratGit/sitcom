class Search::TvShowsController < ApplicationController
  def index
    if params[:query].present?
      sql_query = "title ILIKE :query OR genre ILIKE :query"
      @tv_shows = TvShow.where(sql_query, query: "%#{params[:query]}%")
    else
      @tv_shows = TvShow.all
    end
    # binding.pry
  end
end
