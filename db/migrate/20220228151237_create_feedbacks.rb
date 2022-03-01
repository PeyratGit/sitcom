class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.string :status
      t.string :comment
      t.integer :rating
      t.references :user, null: false, foreign_key: true
      t.references :tv_show, null: false, foreign_key: true

      t.timestamps
    end
  end
end
