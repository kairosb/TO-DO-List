class DailyBoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daily_board, only: %i[show edit update destroy]

  # GET /daily_boards
  def index
    @daily_boards = current_user.daily_boards
  end

  def edit
  end

  # GET /daily_boards/:id
  def show
  end

  # GET /daily_boards/new
  def new
    @daily_board = DailyBoard.new
  end

   # POST /daily_boards
   def create
    @daily_board = current_user.daily_boards.new(daily_board_params)
  
    if @daily_board.save

      create_default_columns(@daily_board)

      tasks = Task.where(todo_list: current_user.todo_lists, completed: false)
                  .order("priority_id ASC, estimate ASC")
  
      allocate_tasks_to_daily_board(@daily_board, tasks)
      redirect_to daily_boards_path, notice: "Quadro diário criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
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
    redirect_to daily_boards_path, notice: "Quadro diário excluído com sucesso!"
  end

  private

  def set_daily_board
    @daily_board = current_user.daily_boards.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to daily_boards_path, alert: "Quadro diário não encontrado."
  end

  def daily_board_params
    params.require(:daily_board).permit(:name, :total_estimate)
  end

  def allocate_tasks_to_daily_board(daily_board, tasks)
    remaining_hours = daily_board.total_estimate
  
    tasks.each do |task|
      break if remaining_hours <= 0 
  
      if task.estimate <= remaining_hours
        TaskAssignment.create!(
          daily_board_id: daily_board.id,
          task_id: task.id,
          board_column_id: daily_board.board_columns.find_by(name: "To Do").id,
          position: 0
        )
        remaining_hours -= task.estimate
      end
    end
  end

  def create_default_columns(daily_board)
    default_columns = ["To Do", "In Progress", "Done"]
    default_columns.each_with_index do |column_name, index|
      daily_board.board_columns.create!(
        name: column_name,
        position: index + 1
      )
    end
  end

end
