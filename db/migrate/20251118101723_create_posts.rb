class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.integer :post_id
      t.integer :chat_thread_id
      t.integer :user_id
      t.string :content
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
