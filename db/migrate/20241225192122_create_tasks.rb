class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :estimate
      t.boolean :completed
      t.references :todo_list, null: false, foreign_key: true
      t.references :priority, null: false, foreign_key: true

      t.timestamps
    end
  end
end
