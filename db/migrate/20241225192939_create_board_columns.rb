class CreateBoardColumns < ActiveRecord::Migration[8.0]
  def change
    create_table :board_columns do |t|
      t.string :name
      t.integer :position
      t.references :boardable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
