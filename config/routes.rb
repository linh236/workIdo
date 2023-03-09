Rails.application.routes.draw do
  devise_for :users
  root "site#index"
  
  resources :projects do 
    resources :members
    get "invite_member/:user_id", to: "members#invite_member", as: "invite_member"
    get "accept_join/:id", to: "members#accept_join", as: "accept_join"
    delete "remove_member/:user_id", to: "members#remove_member", as: "remove_member"
    resources :labels do 
      resources :tasks
    end
  end
  resources :tasks
  put "move_task/:id", to: "tasks#move_task"
  put "move_task_inside", to: "tasks#move_task_inside"
  post "assign_member/:id", to: "tasks#assign_member"
  resources :labels 
  put "move_label", to: "labels#move_label"


  resources :users

  get "list_users", to: "users#list_users"

  resources :activities

  resources :account_notifications
end
