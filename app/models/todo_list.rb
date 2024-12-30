class TodoList < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_one :list_board, dependent: :destroy

  validates :name, presence: true

  validates :icon, inclusion: { in: [
    "icon-tasks.svg",
    "icon-calendar.svg",
    "icon-goals.svg",
    "icon-shopping.svg",
    "icon-home.svg"
  ], allow_blank: true }

  after_create :create_list_board_with_columns

  before_destroy :cleanup_task_assignments

  private

  def create_list_board_with_columns
    list_board = self.create_list_board!(name: "#{self.name} Board")

    [ "To Do", "In Progress", "Done" ].each_with_index do |name, index|
      list_board.board_columns.create!(name: name, position: index)
    end
  end

  def cleanup_task_assignments
    tasks.each do |task|
      task.task_assignments.destroy_all
    end
  end
end
