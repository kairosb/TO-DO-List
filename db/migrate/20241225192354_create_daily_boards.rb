class CreateDailyBoards < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_boards do |t|
      t.string :name
      t.integer :total_estimate
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
