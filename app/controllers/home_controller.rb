class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @pending_tasks_count = current_user.todo_lists.joins(:tasks).where(tasks: { completed: false }).count
  end
end
