Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  get "/home", to: "home#index"

  resources :todo_lists do
    resources :tasks, only: %i[index new edit create show update destroy]
    resources :list_boards, only: %i[index create show update destroy] do
      resources :board_columns, only: %i[index create update destroy]
      resources :task_assignments, only: %i[create update destroy]
    end
  end

  resources :daily_boards do
    resources :board_columns, only: %i[index create update destroy]
    resources :task_assignments, only: %i[create update destroy]
  end
end
