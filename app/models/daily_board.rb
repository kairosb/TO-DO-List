class DailyBoard < ApplicationRecord
  belongs_to :user
  has_many :board_columns, dependent: :destroy
  has_many :task_assignments, dependent: :destroy

  validates :name, :total_estimate, presence: true
  validates :total_estimate, numericality: { greater_than: 0 }
end
