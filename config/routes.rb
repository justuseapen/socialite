Rails.application.routes.draw do
	
	devise_for :users, controllers: {
    sessions: 'sessions',
    omniauth_callbacks: 'callbacks'
  }

  get '/buffer_connection', to: 'buffer_connections#new', as: 'new_buffer_connection'

  root 'lists#index'
  
  resources :lists
  resource :twitter_accounts
  resource :buffer_profiles
  get '/tweets', to: 'tweets#index', as: 'tweets'
  post '/updates', to: 'updates#create', as: 'create_update'
end
