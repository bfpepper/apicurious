Rails.application.routes.draw do
  root "home#index"

  get '/auth/github/callback', to: 'sessions#create'

  resources :dashboard, only: [:index]
  resources :repos, only: [:index]
  resources :orgs, only: [:index]
  resources :commits, only: [:index]
end
