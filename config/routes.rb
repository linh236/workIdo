Rails.application.routes.draw do
  devise_for :users
  root "site#index"

  resources :projects do 
    resources :labels do 
      resources :tasks
    end
  end
  resources :tasks
  put "move_task/:id", to: "tasks#move_task"
end
