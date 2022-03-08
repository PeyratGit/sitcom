class WatchNowsController < ApplicationController
  def index
    @suggestion = current_user.suggestion
  end
end
