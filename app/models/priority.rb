class Priority < ApplicationRecord
  has_many :tasks

  validates :name, presence: true, uniqueness: true
  validates :level, presence: true, numericality: { only_integer: true }
end
