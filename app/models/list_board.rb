class ListBoard < ApplicationRecord
  belongs_to :todo_list
  has_many :board_columns, as: :boardable, dependent: :destroy
  has_many :task_assignments, as: :boardable, dependent: :destroy

  validates :name, presence: true
end
