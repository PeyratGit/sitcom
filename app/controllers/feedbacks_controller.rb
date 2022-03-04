class FeedbacksController < ApplicationController
  def create
    @user = current_user
    @tv_show = TvShow.find(params[:tv_show_id])
    @feedback = Feedback.new(user: @user, tv_show: @tv_show, status: params[:feedback][:status])
    if @feedback.save
      # render json: @feedback
    end
  end

  def update
    @feedback = Feedback.find(params[:id])
    @feedback.update({status: params[:status]})
  end
end
