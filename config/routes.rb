Rails.application.routes.draw do
  post '/login', to: 'users#login'
  post '/signup', to: 'users#create'
  resources :users, only: [:update, :destroy]
  resources :courses, only: [:index, :create, :update, :destroy]
  resources :friendships, only: [:create, :update, :destroy]
  resources :subscriptions, only: [:create, :update, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :comments, only: [:create, :update, :destroy]
end
