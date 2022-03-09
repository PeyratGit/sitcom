class AddLastNameToFollows < ActiveRecord::Migration[6.1]
  def change
    add_column :follows, :last_name, :string
  end
end
