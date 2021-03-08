Rails.application.routes.draw do
  post '/login', to: 'users#login'
  post '/signup', to: 'users#create'
  post '/user', to: 'users#show'
  post '/courses', to: 'courses#index'
  post '/user/friends', to: 'users#friends'
  resources :users, only: [:update, :destroy]
  resources :courses, only: [:create, :update, :destroy]
  resources :friendships, only: [:create, :update, :destroy]
  resources :subscriptions, only: [:create, :update, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :comments, only: [:create, :update, :destroy]
  resources :tokens, only: [:create, :destroy]
end
