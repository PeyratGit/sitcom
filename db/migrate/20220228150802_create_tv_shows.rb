class CreateTvShows < ActiveRecord::Migration[6.1]
  def change
    create_table :tv_shows do |t|
      t.string :title
      t.string :genre
      t.string :description
      t.string :director
      t.float :imdb_rating
      t.integer :episodes_count
      t.integer :seasons_count
      t.string :language
      t.string :poster_url
      t.boolean :netflix
      t.boolean :amazon
      t.boolean :disney

      t.timestamps
    end
  end
end
