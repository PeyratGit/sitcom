class Search::UsersController < ApplicationController
  before_action :set_user, only: [:follow, :unfollow]

  def index
    if params[:query].present?
      sql_query = "last_name ILIKE :query OR first_name ILIKE :query"
      @users = User.where(sql_query, query: "%#{params[:query]}%")
    else
      @users = User.all
      @users = User.order(:first_name)

      ##@followings_ids = current_user.followings.pluck(:id)
      ##@users = current_user.followings.concat(User.where.not(id: @followings_ids))
    end
  end

  def follow
    if current_user.follow(@user.id)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  def unfollow
    if current_user.unfollow(@user.id)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js { render action: :follow }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
