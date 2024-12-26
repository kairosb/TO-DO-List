class BoardColumnsController < ApplicationController
  before_action :set_boardable
  before_action :set_board_column, only: %i[update destroy]

  # GET /board_columns
  def index
    @board_columns = @boardable.board_columns
    render json: @board_columns
  end

  # POST /board_columns
  def create
    @board_column = @boardable.board_columns.new(board_column_params)

    if @board_column.save
      render json: @board_column, status: :created
    else
      render json: { errors: @board_column.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /board_columns/:id
  def update
    if @board_column.update(board_column_params)
      render json: @board_column
    else
      render json: { errors: @board_column.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /board_columns/:id
  def destroy
    @board_column.destroy
    head :no_content
  end

  private

  def set_boardable
    @boardable = if params[:daily_board_id]
                   DailyBoard.find(params[:daily_board_id])
    elsif params[:list_board_id]
                   ListBoard.find(params[:list_board_id])
    end
  end

  def set_board_column
    @board_column = @boardable.board_columns.find(params[:id])
  end

  def board_column_params
    params.require(:board_column).permit(:name, :position)
  end
end
