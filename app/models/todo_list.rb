class TodoList < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_one :list_board, dependent: :destroy

  validates :name, presence: true
end
