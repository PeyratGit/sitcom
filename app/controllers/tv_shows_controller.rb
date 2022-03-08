class TvShowsController < ApplicationController
  def index
    @tv_shows = TvShow.all
    @follows = current_user.followings
  end

  def show
    @tv_show = TvShow.find(params[:id])
    @follows = current_user.followings
    @feedback = Feedback.new
    @feedback_of_user = Feedback.where(tv_show_id: @tv_show.id, user_id: current_user).where.not(comment: nil)[0]
    @feedbacks_empty = Feedback.where(tv_show_id: @tv_show.id, comment: nil)
    @feedbacks_full = Feedback.where(tv_show_id: @tv_show.id).where.not(comment: nil)
    @feedbacks_like_number = Feedback.where(tv_show_id: @tv_show.id, status: "Like").count
    @feedbacks_dislike_number = Feedback.where(tv_show_id: @tv_show.id, status: "Dislike").count
    @feedbacks_superlike_number = Feedback.where(tv_show_id: @tv_show.id, status: "Superlike").count
    @feedbacks_full_number = Feedback.where(tv_show_id: @tv_show.id).where.not(comment: nil).count
  end
end
