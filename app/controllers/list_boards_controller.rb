class ListBoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list
  before_action :set_list_board, only: %i[show update destroy]

  # GET /todo_lists/:todo_list_id/list_board
  def show
    @list_board = @todo_list.list_board
    @columns = @list_board.board_columns.includes(:task_assignments)
    @tasks = @list_board.todo_list.tasks
  end
  

  # POST /todo_lists/:todo_list_id/list_board
  def create
    @list_board = @todo_list.build_list_board(name: @todo_list.name)
    if @list_board.save
      create_default_columns(@list_board)
      redirect_to todo_list_list_board_path(@todo_list), notice: "Board criado com sucesso!"
    else
      redirect_to todo_list_tasks_path(@todo_list), alert: "Não foi possível criar o board."
    end
  end

  # PUT/PATCH /todo_lists/:todo_list_id/list_board
  def update
    if @list_board.update(list_board_params)
      render json: @list_board
    else
      render json: { errors: @list_board.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /todo_lists/:todo_list_id/list_board
  def destroy
    @list_board.destroy
    head :no_content
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_list_board
    @list_board = @todo_list.list_board
  end

  def list_board_params
    params.require(:list_board).permit(:name)
  end

  def create_default_columns(list_board)
    ["To Do", "In Progress", "Done"].each_with_index do |name, index|
      list_board.board_columns.create!(
        name: name,
        position: index + 1
      )
    end
  end
end
