class BoardColumn < ApplicationRecord
  belongs_to :boardable, polymorphic: true
  has_many :task_assignments, dependent: :destroy

  validates :name, :position, presence: true

  before_create :set_default_position

  private

  def set_default_position
    self.position ||= boardable.board_columns.maximum(:position).to_i + 1
  end
end
