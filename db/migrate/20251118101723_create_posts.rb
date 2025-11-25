class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.integer :post_id, null: false
      t.belongs_to :chat_thread, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.string :content
      t.timestamp :deleted_at

      t.timestamps
    end
    add_index :posts, :post_id, unique: true
  end
end
