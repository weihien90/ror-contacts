Rails.application.routes.draw do
  # Homepage
  root 'home#index'

  # Signup path
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # Authentication resource
  resources :users
end
