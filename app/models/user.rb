class User < ApplicationRecord
  has_many :todo_lists
  has_many :daily_boards

  validates :email, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
