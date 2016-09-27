Rails.application.routes.draw do
	devise_for :users, controllers: {
    sessions: 'sessions',
    omniauth_callbacks: 'callbacks'
  }
  root 'lists#index'
  resources :lists
  resource :twitter_accounts
  resource :buffer_profiles
  get '/tweets', to: 'tweets#index', as: 'tweets'
  post '/updates', to: 'updates#create', as: 'create_update'
end
