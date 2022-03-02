class TvShowsController < ApplicationController
  def index
    @tv_shows = TvShow.all
  end

  def show
    @tv_show = TvShow.find(params[:id])
    @feedbacks = Feedback.where(tv_show_id: @tv_show.id)
    @feedbacks_number = Feedback.where(tv_show_id: @tv_show.id).count
  end
end
