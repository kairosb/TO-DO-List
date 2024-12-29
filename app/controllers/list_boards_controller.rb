class ListBoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list

  # GET /todo_lists/:todo_list_id/list_boards
  def index
    @list_boards = @todo_list.list_boards
    render json: @list_boards
  end

  # POST /todo_lists/:todo_list_id/list_boards
  def create
    @list_board = @todo_list.list_boards.new(list_board_params)

    if @list_board.save
      render json: @list_board, status: :created
    else
      render json: { errors: @list_board.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /todo_lists/:todo_list_id/list_boards/:id
  def show
    @list_board = @todo_list.list_boards.find(params[:id])
    render json: @list_board
  end

  # PUT/PATCH /todo_lists/:todo_list_id/list_boards/:id
  def update
    @list_board = @todo_list.list_boards.find(params[:id])
    if @list_board.update(list_board_params)
      render json: @list_board
    else
      render json: { errors: @list_board.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /todo_lists/:todo_list_id/list_boards/:id
  def destroy
    @list_board = @todo_list.list_boards.find(params[:id])
    @list_board.destroy
    head :no_content
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def list_board_params
    params.require(:list_board).permit(:name)
  end
end
