Rails.application.routes.draw do

  # Defines the root path route ("/")
  root "splash#index"

 # Defining custom path for devise
 devise_for :users, path: 'auth', path_names: {
  sign_in: 'login',
  sign_out: 'logout',
  password: 'secret',
  confirmation: 'verification',
  unlock: 'unblock',
  registration: 'register'
}, controllers: {
  sessions: 'users/sessions'
}
  
  resources :users do
    resources :categories do [:index, :show, :new, :create, :destroy]
      resources :deals, only: [:index, :show, :new, :create, :destroy]
    end
  end

  # For testing definitions
  # get '/categories/create', to: 'categories#create'
  # get '/deals', to: 'deals#index', as: :deals
  # get '/deals/new', to: 'deals#new'
  # get '/deals/create', to: 'deals#create'
  # get '/deals/destroy', to: 'deals#destroy'
  # get '/categories', to: 'categories#index', as: :categories
  get '/categories/most_recent', to: 'categories#most_recent', as: :most_recent_categories
  get '/categories/oldest', to: 'categories#oldest', as: :oldest_categories
  get '/uploads/:filename', to: 'uploads#show'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
end
