class TodoList < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_one :list_board, dependent: :destroy

  validates :name, presence: true

  after_create :create_list_board_with_columns

  private

  def create_list_board_with_columns
    list_board = self.create_list_board!(name: "#{self.name} Board")

    # Criar colunas padrão
    ["To Do", "In Progress", "Done"].each_with_index do |name, index|
      list_board.board_columns.create!(name: name, position: index)
    end
  end
end
