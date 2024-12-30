class AddBoardableToTaskAssignments < ActiveRecord::Migration[8.0]
  def change
    add_column :task_assignments, :boardable_type, :string
    add_column :task_assignments, :boardable_id, :bigint
    remove_column :task_assignments, :list_board_id, :bigint
    remove_column :task_assignments, :daily_board_id, :bigint
    add_index :task_assignments, [ :boardable_type, :boardable_id ]
  end
end
