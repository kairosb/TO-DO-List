class CreateBoardColumns < ActiveRecord::Migration[8.0]
  def change
    create_table :board_columns do |t|
      t.string :name
      t.integer :position
      t.references :daily_board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
