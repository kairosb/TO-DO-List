# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_12_30_141826) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "board_columns", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "boardable_type", null: false
    t.bigint "boardable_id", null: false
    t.index ["boardable_type", "boardable_id"], name: "index_board_columns_on_boardable"
  end

  create_table "daily_boards", force: :cascade do |t|
    t.string "name"
    t.integer "total_estimate"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_daily_boards_on_user_id"
  end

  create_table "list_boards", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "todo_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["todo_list_id"], name: "index_list_boards_on_todo_list_id"
  end

  create_table "priorities", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_assignments", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.bigint "board_column_id", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "boardable_type"
    t.bigint "boardable_id"
    t.index ["board_column_id"], name: "index_task_assignments_on_board_column_id"
    t.index ["boardable_type", "boardable_id"], name: "index_task_assignments_on_boardable_type_and_boardable_id"
    t.index ["task_id"], name: "index_task_assignments_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "estimate"
    t.boolean "completed"
    t.bigint "todo_list_id", null: false
    t.bigint "priority_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["priority_id"], name: "index_tasks_on_priority_id"
    t.index ["todo_list_id"], name: "index_tasks_on_todo_list_id"
  end

  create_table "todo_lists", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_todo_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "daily_boards", "users"
  add_foreign_key "list_boards", "todo_lists"
  add_foreign_key "task_assignments", "board_columns"
  add_foreign_key "task_assignments", "tasks"
  add_foreign_key "tasks", "priorities"
  add_foreign_key "tasks", "todo_lists"
  add_foreign_key "todo_lists", "users"
end
