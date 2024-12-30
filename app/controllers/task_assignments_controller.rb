class TaskAssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board_column, only: %i[create]
  before_action :set_task_assignment, only: %i[update destroy]

  # POST /task_assignments
  def create
    @task_assignment = TaskAssignment.new(task_assignment_params)
    @task_assignment.boardable = @board_column.boardable
    @task_assignment.board_column = @board_column

    if @task_assignment.save
      render json: @task_assignment, status: :created
    else
      render json: { errors: @task_assignment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @task_assignment.update(task_assignment_params)
      boardable = @task_assignment.board_column.boardable

      last_column = boardable.board_columns.order(:position).last

      if @task_assignment.board_column == last_column
        @task_assignment.task.update!(completed: true)
      else
        @task_assignment.task.update!(completed: false)
      end

        render json: { status: "success", completed: @task_assignment.task.completed }
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
    params.require(:task_assignment).permit(:task_id, :board_column_id)
  end
end
