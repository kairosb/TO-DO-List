class ChangeNullConstraintsOnTaskAssignments < ActiveRecord::Migration[8.0]
  def change
    change_column_null :task_assignments, :list_board_id, true
    change_column_null :task_assignments, :daily_board_id, true
  end
end
