class CreateTaskAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :task_assignments do |t|
      t.references :boardable, null: false, polymorphic: true
      t.references :task, null: false, foreign_key: true
      t.references :board_column, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
