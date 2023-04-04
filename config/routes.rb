Rails.application.routes.draw do
  get 'bookings/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "users#index"
  # register
  root "sessions#new"
  get "register/" => "users#new",as:"user"
  post "register/" => "users#create" 
  

  # login
  get "login/" => "sessions#new",as:'login'
  post "login/" => "sessions#create"
  delete "logout/" => "sessions#destroy"
  get "logout" => "sessions#destroy"

  # services
  get "services/" => "services#index", as:"services"
  
  get "appoint/:id" => "appointments#show", as:"appoint"
  post "appoint/:id" => "appointments#create"

  # cart
  get "cart/" => "cart#index" ,as:"cart"
  get "cart/:id" =>"cart#new", as:"cart_new"
  post "cart/:id" =>"cart#create"
  delete "cart/:id/delete" => "cart#destroy", as:"cart_delete"
  get "cart/:id/delete" => "cart#destroy"


  get  "add_address/" => "addresses#new",as:"address"
  post "add_address/" => "addresses#create"
  get "edit_address/:id" => "addresses#edit", as: "edit_address"
  patch "edit_address/:id" => "addresses#update"
  delete "address/:id/delete" => "addresses#destroy",as:"address_delete"
  get "address/:id/delete" => "addresses#destroy"
  

end
