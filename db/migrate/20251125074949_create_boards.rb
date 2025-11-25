class CreateBoards < ActiveRecord::Migration[8.1]
  def change
    create_table :boards do |t|
      t.integer :board_id
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
