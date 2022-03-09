class TvShow < ApplicationRecord
  has_many :feedbacks, dependent: :destroy
  has_many :wishes, dependent: :destroy

  def popularity_score(user)
    followings = user.followings.map(&:id)
    tv_shows_with_feedbacks_from_followings = Feedback.where('user_id in (?)', followings).where.not(status: 'Unwatched').map(&:tv_show_id).uniq
    tv_show_feedbacks_from_followings = Feedback.where('user_id in (?)', followings).where(tv_show: tv_show)
    tv_show_watched_from_followings = Feedback.where('user_id in (?)', followings).where(tv_show: self).where.not(status: 'Unwatched').count
    tv_show_disliked_from_followings = Feedback.where('user_id in (?)', followings).where(tv_show: self).where(status: 'Dislike').count
    tv_show_liked_from_followings = Feedback.where('user_id in (?)', followings).where(tv_show: self).where(status: 'Like').count
    tv_show_superliked_from_followings = Feedback.where('user_id in (?)', followings).where(tv_show: self).where(status: 'Superlike').count
    numerator = tv_show_liked_from_followings + (2 * tv_show_superliked_from_followings)
    denominator = numerator + tv_show_disliked_from_followings
    like_score = numerator.fdiv(denominator)

    rating = 0
    index = 0
    rating = tv_show_feedbacks_from_followings.each do |feedback|
      rating += feedback.rating.nil? ? 0 : feedback.rating
      index += feedback.rating.nil? ? 0 : 1
    end
    average_rating = index.positive ? rating.fdiv(index) : 0

    count = 0
    tv_shows_with_feedbacks_from_followings.each do |tv_show_id|
      new_count = Feedback.where('user_id in (?)', followings).where(tv_show_id: tv_show_id).where.not(status: 'Unwatched').count
      count = new_count if new_count > count
    end
    watched_score = tv_show_watched_from_followings.fdiv(count)

    if tv_show_feedbacks_from_followings.nil? || tv_show_watched_from_followings.zero?
      return 0
    elsif average_rating.zero?
      return (0.7 * like_score) + (0.3 * watched_score)
    else
      return (0.6 * like_score) + (0.2 * average_rating) + (0.2 * watched_score)
    end
  end
end
