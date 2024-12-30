class Task < ApplicationRecord
  belongs_to :todo_list
  belongs_to :priority
  has_many :task_assignments, dependent: :destroy

  validates :title, :estimate, presence: true
  validates :estimate, numericality: { greater_than: 0 }

  after_create :add_to_list_board
  after_update :update_board_column_if_completed_changed

  private

  def add_to_list_board
    list_board = self.todo_list.list_board
    return unless list_board

    column = completed ? list_board.board_columns.order(:position).last : list_board.board_columns.find_by(name: "To Do")
    return unless column

    TaskAssignment.create!(
      task_id: self.id,
      board_column_id: column.id,
      boardable: list_board,
      position: 0
    )
  end

  def update_board_column_if_completed_changed
    return unless saved_change_to_completed?

    assignment = task_assignments.find_by(boardable: todo_list.list_board)
    return unless assignment

    new_column = completed ? assignment.boardable.board_columns.order(:position).last : assignment.boardable.board_columns.find_by(name: "To Do")
    assignment.update!(board_column_id: new_column.id) if new_column
  end
end
