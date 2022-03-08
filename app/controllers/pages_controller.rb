class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  # helper_method :devise_mapping

  def home
    @tv_shows = TvShow.all
  end

  def confidentiality
  end

  def datauser
  end

  # def devise_mapping
  #   @devise_mapping ||= request.env["devise.mapping"]
  # end
end
