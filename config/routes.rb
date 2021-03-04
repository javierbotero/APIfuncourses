Rails.application.routes.draw do
  post '/loggin', to: 'users#loggin'
  post '/signup', to: 'users#create'
  resources :user, only: [:update, :destroy]
end
