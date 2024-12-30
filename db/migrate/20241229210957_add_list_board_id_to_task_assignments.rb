class AddListBoardIdToTaskAssignments < ActiveRecord::Migration[8.0]
  def change
    add_column :task_assignments, :list_board_id, :bigint
    add_foreign_key :task_assignments, :list_boards
    add_index :task_assignments, :list_board_id
  end
end
