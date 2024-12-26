class User < ApplicationRecord
  has_many :todo_lists
  has_many :daily_boards

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end