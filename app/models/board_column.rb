class BoardColumn < ApplicationRecord
  belongs_to :daily_board
  has_many :task_assignments, dependent: :destroy

  validates :name, :position, presence: true
end
