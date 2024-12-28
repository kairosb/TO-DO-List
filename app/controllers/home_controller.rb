class HomeController < ApplicationController
  before_action :authenticate_user!
    def index
      # Lógica para calcular o número de tarefas pendentes
      @pending_tasks_count = Task.where(completed: false).count
    end
end
