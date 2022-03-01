class AddCanalToTvShows < ActiveRecord::Migration[6.1]
  def change
    add_column :tv_shows, :canal, :boolean
  end
end
