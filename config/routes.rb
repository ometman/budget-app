Rails.application.routes.draw do

# Defines the root path route ("/")
  root "splash#index"
  get '/home', to: 'categories#index', as: :categories
  get '/categories/most_recent', to: 'categories#most_recent', as: :most_recent_categories
  get '/categories/oldest', to: 'categories#oldest', as: :oldest_categories

  devise_for :users, path: 'auth', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    password: 'secret',
    confirmation: 'verification',
    unlock: 'unblock',
    registration: 'register'
  } do
    
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users
  resources :categories
  resources :deals
  
end
