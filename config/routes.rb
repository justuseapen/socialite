Rails.application.routes.draw do
  root 'lists#index'
  resources :lists
  resource :twitter_accounts
  get '/lists/:quality_percentage', to: 'tweets#index', as: 'tweets'
  resource :buffer_profiles
end
