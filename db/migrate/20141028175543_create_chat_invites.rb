class CreateChatInvites < ActiveRecord::Migration
  def change
    create_table :chat_invites do |t|
      t.integer :host_id
      t.integer :guest_id

      t.timestamps null: false
    end
  end
end
