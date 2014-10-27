class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :user_name
      t.text :comment_body
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
