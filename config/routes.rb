Rails.application.routes.draw do
 get 'sessions/new'
 root 'welcome#index'
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 resources :users

 resources :tasks

 get "/sign_up" => "users#new", as: "sign_up"
 get "/sign_in" => "sessions#new", as: "sign_in"
 post "/sign_in" =>"sessions#create", as: "signed_in"
 get "/sign_out" => "sessions#destroy", as: "sign_out"

 get "/auth/:provider/callback" => "sessions#create_from_omniauth"

 get "/dashboard" => "dashboard#index", as: "dashboard"

 patch "/tasks/update_status/:id" => "tasks#update_status", as: "update_status"

 
 
end
