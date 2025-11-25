class CreateChatThreads < ActiveRecord::Migration[8.1]
  def change
    create_table :chat_threads do |t|
      t.integer :chat_thread_id, null: false
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :board, null: false, foreign_key: true
      t.string :title
      t.string :description

      t.timestamps
    end
    add_index :posts, :chat_thread_id, unique: true
  end
end
