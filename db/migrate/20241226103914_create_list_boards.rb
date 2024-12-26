class CreateListBoards < ActiveRecord::Migration[8.0]
  def change
    create_table :list_boards do |t|
      t.string :name, null: false
      t.references :todo_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
