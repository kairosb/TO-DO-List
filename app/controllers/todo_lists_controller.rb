class TodoListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list, only: %i[ show edit update destroy]

  # GET /todo_lists
  def index
    @todo_lists = current_user.todo_lists
  end

  def show
    redirect_to todo_lists_path, notice: "A lista foi carregada com sucesso."
  end

  # GET /todo_lists/new
  def new
    @todo_list = TodoList.new
  end

  # POST /todo_lists
  def create
    @todo_list = current_user.todo_lists.new(todo_list_params)

    if @todo_list.save
      redirect_to todo_lists_path, notice: "Lista criada com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /todo_lists/:id/edit
  def edit
    # `@todo_list` já está definido pelo before_action `set_todo_list`
  end

  # PUT/PATCH /todo_lists/:id
  def update
    if @todo_list.update(todo_list_params)
      redirect_to todo_lists_path, notice: "Lista atualizada com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

# DELETE /todo_lists/:id
def destroy
  list_board = @todo_list.list_board

  if list_board
    list_board.board_columns.each do |column|
      column.task_assignments.destroy_all
    end
    list_board.destroy
  end

  @todo_list.destroy
  redirect_to todo_lists_path, notice: "Lista removida com sucesso!"
end

  private

  def set_todo_list
    @todo_list = current_user.todo_lists.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to todo_lists_path, alert: "Lista não encontrada."
  end

  def todo_list_params
    params.require(:todo_list).permit(:name)
  end
end
