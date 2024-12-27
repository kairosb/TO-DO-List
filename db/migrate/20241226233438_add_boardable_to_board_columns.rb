class AddBoardableToBoardColumns < ActiveRecord::Migration[8.0]
  def change
    # Adicione as colunas polimórficas inicialmente como null: true
    add_reference :board_columns, :boardable, polymorphic: true, null: true

    # Popule os valores das colunas polimórficas
    reversible do |dir|
      dir.up do
        BoardColumn.reset_column_information
        BoardColumn.find_each do |column|
          column.update!(boardable_type: "DailyBoard", boardable_id: column.daily_board_id)
        end
      end
    end

    # Remova a referência antiga
    remove_reference :board_columns, :daily_board, foreign_key: true

    # Agora altere as colunas para null: false
    change_column_null :board_columns, :boardable_type, false
    change_column_null :board_columns, :boardable_id, false
  end
end
