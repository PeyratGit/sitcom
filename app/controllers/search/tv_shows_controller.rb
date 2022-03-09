class Search::TvShowsController < ApplicationController
  def index
    if params[:query].present?
      sql_query = "title ILIKE :query OR genre ILIKE :query"
      if params[:filter].present?
        netflix_tv_shows = params[:filter]['netflix'] == '1' ? TvShow.where(sql_query, query: "%#{params[:query]}%").where(netflix: true) : []
        amazon_tv_shows = params[:filter]['amazon'] == '1' ? TvShow.where(sql_query, query: "%#{params[:query]}%").where(amazon: true) : []
        disney_tv_shows = params[:filter]['disney'] == '1' ? TvShow.where(sql_query, query: "%#{params[:query]}%").where(disney: true) : []
        ocs_tv_shows = params[:filter]['ocs'] == '1' ? TvShow.where(sql_query, query: "%#{params[:query]}%").where(ocs: true) : []
        canal_tv_shows = params[:filter]['canal'] == '1' ? TvShow.where(sql_query, query: "%#{params[:query]}%").where(canal: true) : []
        tv_shows_non_ordered = netflix_tv_shows + amazon_tv_shows + disney_tv_shows + ocs_tv_shows + canal_tv_shows
        @tv_shows = tv_shows_non_ordered.count.zero? ? TvShow.where(sql_query, query: "%#{params[:query]}%") : tv_shows_non_ordered.uniq.sort_by(&:id)
      else
        @tv_shows = TvShow.where(sql_query, query: "%#{params[:query]}%")
      end
    elsif params[:filter].present?
      netflix_tv_shows = params[:filter]['netflix'] == '1' ? TvShow.where(netflix: true) : []
      amazon_tv_shows = params[:filter]['amazon'] == '1' ? TvShow.where(amazon: true) : []
      disney_tv_shows = params[:filter]['disney'] == '1' ? TvShow.where(disney: true) : []
      ocs_tv_shows = params[:filter]['ocs'] == '1' ? TvShow.where(ocs: true) : []
      canal_tv_shows = params[:filter]['canal'] == '1' ? TvShow.where(canal: true) : []
      tv_shows_non_ordered = netflix_tv_shows + amazon_tv_shows + disney_tv_shows + ocs_tv_shows + canal_tv_shows
      @tv_shows = tv_shows_non_ordered.count.zero? ? TvShow.all : tv_shows_non_ordered.uniq.sort_by(&:id)
    else
      @tv_shows = TvShow.all
    end
  end
end
