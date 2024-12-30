class Task < ApplicationRecord
  belongs_to :todo_list
  belongs_to :priority
  has_many :task_assignments, dependent: :destroy

  validates :title, :estimate, presence: true
  validates :estimate, numericality: { greater_than: 0 }

  after_create :add_to_list_board

  private

  def add_to_list_board
    list_board = self.todo_list.list_board
    return unless list_board

    to_do_column = list_board.board_columns.find_by(name: "To Do")
    return unless to_do_column

    TaskAssignment.create!(
      task_id: self.id,
      board_column_id: to_do_column.id,
      boardable: list_board,
      position: 0
    )
  end
end
