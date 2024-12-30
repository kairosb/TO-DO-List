class AddIconToTodoLists < ActiveRecord::Migration[8.0]
  def change
    add_column :todo_lists, :icon, :string
  end
end
