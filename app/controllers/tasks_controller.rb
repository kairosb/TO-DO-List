class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list
  before_action :set_task, only: %i[show edit update destroy]

  # GET /todo_lists/:todo_list_id/tasks
  def index
    @tasks = @todo_list.tasks
  end

  # GET /todo_lists/:todo_list_id/tasks/:id/edit
  def edit
    # Apenas carrega a tarefa para edição
  end

  # GET /todo_lists/:todo_list_id/tasks/new
  def new
    @task = @todo_list.tasks.new
  end

  # GET /todo_lists/:todo_list_id/tasks/:id
  def show
  end

  # POST /todo_lists/:todo_list_id/tasks
  def create
    @task = @todo_list.tasks.new(task_params)

    if @task.save
      redirect_to todo_list_tasks_path(@todo_list), notice: "Tarefa criada com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end



  # PUT/PATCH /todo_lists/:todo_list_id/tasks/:id
  def update
    update_params = params.require(:task).permit(:title, :description, :estimate, :completed, :priority_id)

    if @task.update(update_params)
      redirect_to todo_list_tasks_path(@todo_list), notice: "Tarefa atualizada com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /todo_lists/:todo_list_id/tasks/:id
  def destroy
    if @task.destroy
      redirect_to todo_list_tasks_path(@todo_list), notice: "Tarefa removida com sucesso!"
    else
      redirect_to todo_list_tasks_path(@todo_list), alert: "Erro ao remover a tarefa."
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to todo_list_tasks_path(@todo_list), alert: "Tarefa não encontrada na lista."
  end


  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_task
    @task = @todo_list.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :estimate, :completed, :priority_id)
  end
end
