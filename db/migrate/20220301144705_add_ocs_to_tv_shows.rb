class AddOcsToTvShows < ActiveRecord::Migration[6.1]
  def change
    add_column :tv_shows, :ocs, :boolean
  end
end
