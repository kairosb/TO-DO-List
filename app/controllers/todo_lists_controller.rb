class TodoListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_list, only: [ :show, :update, :destroy ]

  # GET /todo_lists
  def index
    @todo_lists = current_user.todo_lists
    render json: @todo_lists
  end

  # GET /todo_lists/:id
  def show
    render json: @todo_list
  end

  # POST /todo_lists
  def create
    @todo_list = current_user.todo_lists.new(todo_list_params)

    if @todo_list.save
      render json: @todo_list, status: :created
    else
      render json: { errors: @todo_list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /todo_lists/:id
  def update
    if @todo_list.update(todo_list_params)
      render json: @todo_list
    else
      render json: { errors: @todo_list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /todo_lists/:id
  def destroy
    @todo_list.destroy
    head :no_content
  end

  private

  def set_todo_list
    @todo_list = current_user.todo_lists.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "TodoList not found" }, status: :not_found
  end

  def todo_list_params
    params.require(:todo_list).permit(:name)
  end
end
