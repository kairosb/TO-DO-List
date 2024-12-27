class TaskAssignment < ApplicationRecord
  belongs_to :task
  belongs_to :board_column

  validates :position, numericality: { greater_than_or_equal_to: 0 }
end
