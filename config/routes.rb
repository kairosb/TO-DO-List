Rails.application.routes.draw do
  get "home/index"
  devise_for :users

  resources :todo_lists do
    resources :tasks, only: %i[index create show update destroy]
    resources :list_boards, only: %i[index create show update destroy] do
      resources :board_columns, only: %i[index create update destroy]
    end
  end

  resources :daily_boards do
    resources :board_columns, only: %i[index create update destroy]
    resources :task_assignments, only: %i[create update destroy]
  end

  resources :list_boards do
    resources :task_assignments, only: %i[create update destroy]
  end

  root "home#index"
  get "/home", to: "home#index"
end
