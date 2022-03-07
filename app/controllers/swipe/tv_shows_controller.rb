class Swipe::TvShowsController < ApplicationController
  def index
    @user = current_user
    tv_shows_with_feedback_given = Feedback.where(user_id: current_user).map(&:tv_show_id)
    @tv_shows = TvShow.where.not(id: tv_shows_with_feedback_given)
  end
end
