class CreatePriorities < ActiveRecord::Migration[8.0]
  def change
    create_table :priorities do |t|
      t.string :name
      t.integer :level

      t.timestamps
    end
  end
end
