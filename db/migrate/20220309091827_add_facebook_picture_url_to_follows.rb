class AddFacebookPictureUrlToFollows < ActiveRecord::Migration[6.1]
  def change
    add_column :follows, :facebook_picture_url, :string
  end
end
