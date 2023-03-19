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
  resources :tasks do 
    resources :comments
  end
  put "move_task/:id", to: "tasks#move_task"
  put "move_task_inside", to: "tasks#move_task_inside"
  post "assign_member/:id", to: "tasks#assign_member"
  resources :labels 
  put "move_label", to: "labels#move_label"


  resources :users

  get "list_users", to: "users#list_users"
  get "profile/:id", to: "users#profile", as: "profile"
  get "chat/:id", to: "users#chat", as: "chat"
  
  resources :activities

  resources :account_notifications
  get "account_mark_read/:id", to: "account_notifications#mark_read"

  resources :rooms do 
    post "invite/:user_id", to: "rooms#invite", as: "invite"
    get "accept_invite/:user_id", to: "rooms#accept_invite", as: "accept_invite"
    resources :messages
  end

  post "join_room/:id", to: "rooms#join_room", as: "join_room"
  post "leave_room/:id", to: "rooms#leave_room", as: "leave_room"
end
