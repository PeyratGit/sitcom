class Search::UsersController < ApplicationController
  def index
    if params[:query].present?
      sql_query = "last_name ILIKE :query OR first_name ILIKE :query"
      @users = User.where(sql_query, query: "%#{params[:query]}%")
    else
      @users = User.all
    end
  end
end
