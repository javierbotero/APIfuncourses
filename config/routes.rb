Rails.application.routes.draw do
  post '/login', to: 'users#login'
  post '/signup', to: 'users#create'
  resources :users, only: [:update, :destroy]
  resources :courses, only: [:index, :create, :update, :destroy]
end
