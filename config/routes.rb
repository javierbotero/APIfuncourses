Rails.application.routes.draw do
  post '/loggin', to: 'users#loggin'
  post '/signup', to: 'users#create'
  resources :users, only: [:update, :destroy]
end
