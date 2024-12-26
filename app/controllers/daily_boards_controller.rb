class DailyBoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daily_board, only: %i[show update destroy]

  # GET /daily_boards
  def index
    @daily_boards = current_user.daily_boards
    render json: @daily_boards
  end

  # GET /daily_boards/:id
  def show
    render json: @daily_board
  end

  # POST /daily_boards
  def create
    @daily_board = current_user.daily_boards.new(daily_board_params)
    if @daily_board.save
      render json: @daily_board, status: :created
    else
      render json: { errors: @daily_board.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /daily_boards/:id
  def update
    if @daily_board.update(daily_board_params)
      render json: @daily_board
    else
      render json: { errors: @daily_board.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /daily_boards/:id
  def destroy
    @daily_board.destroy
    head :no_content
  end

  private

  def set_daily_board
    @daily_board = current_user.daily_boards.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Quadro não encontrado" }, status: :not_found
  end

  def daily_board_params
    params.require(:daily_board).permit(:name, :total_hours)
  end
end
