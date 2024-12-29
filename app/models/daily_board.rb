class DailyBoard < ApplicationRecord
  belongs_to :user
  has_many :task_assignments, dependent: :destroy
  has_many :tasks, through: :task_assignments
  has_many :board_columns, as: :boardable, dependent: :destroy

  validates :name, :total_estimate, presence: true
  validates :total_estimate, numericality: { greater_than_or_equal: 0 }

  def default_board_column
    board_columns.find_or_create_by(name: 'To Do') do |column|
      column.position = 1
    end
  end
end
