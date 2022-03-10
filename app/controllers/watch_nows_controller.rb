class WatchNowsController < ApplicationController
  def index
    count = 0
    if params[:count].present?
      count = params[:count].to_i
      #count 0 si on arrive à la fin
    end
    @suggestion = current_user.suggestion(count)
    @superliked_users = current_user.superliked_by
    if (count + 1) == current_user.suggestions_count
      @next_movie = 0
    else
      @next_movie = params[:count].to_i + 1
    end

  end
end
