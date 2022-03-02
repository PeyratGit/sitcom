class FeedbacksController < ApplicationController
  def create
    @user = current_user
    @tv_show = TvShow.find(params[:tv_show_id])
    @feedback = Feedback.new(user: @user, tv_show: @tv_show, status: 'Like')
    if @feedback.save
      redirect_to swipe_tv_shows_path
    else
      render '/tv_shows'
    end
  end
end
