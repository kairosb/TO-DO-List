class BoardColumn < ApplicationRecord
  belongs_to :boardable, polymorphic: true
  has_many :task_assignments, dependent: :destroy

  validates :name, :position, presence: true
end
