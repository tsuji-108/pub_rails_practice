class CreateChatThreads < ActiveRecord::Migration[8.1]
  def change
    create_table :chat_threads do |t|
      t.references :user, null: false, foreign_key: true
      t.references :board, null: false, foreign_key: true
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
