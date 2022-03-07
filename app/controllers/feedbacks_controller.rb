class FeedbacksController < ApplicationController
  def create
    @user = current_user
    @tv_show = TvShow.find(params[:tv_show_id])
    @feedback = Feedback.new(user: @user, tv_show: @tv_show, status: params[:feedback][:status])

    @feedbacks_like_number = Feedback.where(tv_show_id: @tv_show.id, status: "Like").count
    @feedbacks_dislike_number = Feedback.where(tv_show_id: @tv_show.id, status: "Dislike").count
    @feedbacks_superlike_number = Feedback.where(tv_show_id: @tv_show.id, status: "Superlike").count

    if @feedback.save
      render partial:"shared/likes-votes-scores", locals: {tv_show: @tv_show, feedbacks_superlike_number: @feedbacks_superlike_number, feedbacks_like_number: @feedbacks_like_number, feedbacks_dislike_number: @feedbacks_dislike_number}
    end
  end

  def update
    @tv_show = TvShow.find(params[:tv_show_id])

    @feedback = Feedback.find(params[:id])
    @feedback.update({status: params[:status]})
    
    @feedbacks_like_number = Feedback.where(tv_show_id: @tv_show.id, status: "Like").count
    @feedbacks_dislike_number = Feedback.where(tv_show_id: @tv_show.id, status: "Dislike").count
    @feedbacks_superlike_number = Feedback.where(tv_show_id: @tv_show.id, status: "Superlike").count

    render partial:"shared/likes-votes-scores", locals: {tv_show: @tv_show, feedbacks_superlike_number: @feedbacks_superlike_number, feedbacks_like_number: @feedbacks_like_number, feedbacks_dislike_number: @feedbacks_dislike_number}
  end
end
