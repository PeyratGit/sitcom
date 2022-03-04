class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @tv_shows = TvShow.all
  end

  def confidentiality
  end

  def datauser
  end
end
