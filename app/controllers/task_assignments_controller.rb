class TaskAssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board_column, only: %i[create]
  before_action :set_task_assignment, only: %i[update destroy]

  # POST /task_assignments
  def create
    @task_assignment = @board_column.task_assignments.new(task_assignment_params)

    if @task_assignment.save
      render json: @task_assignment, status: :created
    else
      render json: { errors: @task_assignment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /task_assignments/:id
  def update
    if @task_assignment.update(task_assignment_params)
      render json: @task_assignment
    else
      render json: { errors: @task_assignment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /task_assignments/:id
  def destroy
    @task_assignment.destroy
    head :no_content
  end

  private

  def set_board_column
    @board_column = BoardColumn.find(params[:board_column_id])
  end

  def set_task_assignment
    @task_assignment = TaskAssignment.find(params[:id])
  end

  def task_assignment_params
    params.require(:task_assignment).permit(:task_id, :position)
  end
end
