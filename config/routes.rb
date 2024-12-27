Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Autenticação com Devise
  devise_for :users

  # Daily Boards e colunas associadas
  resources :daily_boards do
    resources :board_columns, only: %i[index create update destroy]
  end

  # Todo Lists e tarefas associadas
  resources :todo_lists do
    resources :tasks
  end

  # Task Assignments para Daily Boards
  resources :daily_boards, only: [] do
    resources :task_assignments, only: %i[create update destroy]
  end

  # Task Assignments para List Boards
  resources :list_boards, only: [] do
    resources :task_assignments, only: %i[create update destroy]
  end

  # List Boards e colunas associadas
  resources :todo_lists, only: [] do
    resources :list_boards, only: %i[index create show update destroy] do
      resources :board_columns, only: %i[index create update destroy]
    end
  end
end
