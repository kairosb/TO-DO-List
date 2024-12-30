Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  get "/home", to: "home#index"

  get "/pending_tasks", to: "tasks#pending", as: :pending_tasks

  resources :todo_lists do
    resources :tasks, only: %i[index new edit create show update destroy]
    resource :list_board, only: %i[show create update destroy] do
      resources :board_columns, only: %i[index create update destroy]
      resources :task_assignments, only: %i[create update destroy]
    end
  end

  resources :daily_boards do
    resources :board_columns, only: %i[index new create update destroy]
    resources :task_assignments, only: %i[new create update destroy]
  end

  resources :task_assignments, only: [ :update ]
end
