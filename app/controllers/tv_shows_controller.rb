class TvShowsController < ApplicationController
  def index
    @tv_shows = TvShow.all
    @follows = current_user.followings

    tv_show_ids = Wish.where(user_id: current_user).map(&:tv_show_id)
    @tv_shows_wishlist = TvShow.where(id: tv_show_ids)

    @last_feedbacks = []
    @last_feedbacks_user = []
    @last_feedbacks_shows = []
    @follows.each do |follow|
      follow.feedbacks.where.not(comment: nil).each do |feedback|
        @last_feedbacks << feedback
        @last_feedbacks_shows << TvShow.find(feedback.tv_show_id)
        @last_feedbacks_user << User.find(feedback.user_id)
      end
    end
  end

  def show
    @wish = Wish.new
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
