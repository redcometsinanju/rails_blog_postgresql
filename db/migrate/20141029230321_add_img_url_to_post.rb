class AddImgUrlToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :img_url, :string
  	remove_column :posts, :image_url, :string
  end
end
