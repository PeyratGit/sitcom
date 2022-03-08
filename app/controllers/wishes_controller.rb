class WishesController < ApplicationController
  def index
    tv_show_ids = Wish.where(user_id: current_user).map(&:tv_show_id)
    @tv_shows = TvShow.where(id: tv_show_ids)
  end

  def create
    @tv_show=TvShow.find(params[:tv_show_id])
    Wish.create!(
      user: current_user,
      tv_show: @tv_show
    )
    redirect_to @tv_show
  end

  def destroy
    @wish = Wish.find(params[:id])
    @wish.destroy
    render '/'
  end
end
