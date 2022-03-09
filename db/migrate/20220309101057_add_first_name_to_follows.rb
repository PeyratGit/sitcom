class AddFirstNameToFollows < ActiveRecord::Migration[6.1]
  def change
    add_column :follows, :first_name, :string
  end
end
