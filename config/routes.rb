Rails.application.routes.draw do
  root 'lists#index'
  resources :lists
  resource :twitter_accounts
  resource :buffer_profiles
  get '/tweets', to: 'tweets#index', as: 'tweets'
end
