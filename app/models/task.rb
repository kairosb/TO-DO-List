class Task < ApplicationRecord
  belongs_to :todo_list
  belongs_to :priority
  has_many :task_assignments, dependent: :destroy

  validates :title, :estimate, presence: true
  validates :estimate, numericality: { greater_than: 0 }
end
