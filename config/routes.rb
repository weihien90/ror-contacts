Rails.application.routes.draw do
  # Homepage
  root 'home#index'

  # Signup path
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # Authentication path
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users

  # Contacts
  resources :contacts do
    collection do
      get 'archived'
    end

    member do
      patch 'restore'
    end
  end
end
