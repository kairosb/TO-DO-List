class TasksController < ApplicationController
  before_action :set_todo_list
  before_action :set_task, only: %i[show update destroy]

  # GET /todo_lists/:todo_list_id/tasks
  def index
    @tasks = @todo_list.tasks
    render json: @tasks
  end

  # GET /todo_lists/:todo_list_id/tasks/:id
  def show
    render json: @task
  end

  # POST /todo_lists/:todo_list_id/tasks
  def create
    @task = @todo_list.tasks.build(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /todo_lists/:todo_list_id/tasks/:id
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /todo_lists/:todo_list_id/tasks/:id
  def destroy
    @task.destroy
    head :no_content
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
