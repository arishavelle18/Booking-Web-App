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
  
  get "booking/:id" => "bookings#show", as:"book"
  post "booking/:id" => "bookings#create"
end
