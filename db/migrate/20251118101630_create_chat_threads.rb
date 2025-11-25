class CreateChatThreads < ActiveRecord::Migration[8.1]
  def change
    create_table :chat_threads do |t|
      t.integer :chat_thread_id
      t.integer :user_id
      t.integer :board_id
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
