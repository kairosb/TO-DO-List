class TodoList < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :list_boards, dependent: :destroy

  validates :name, presence: true
end
