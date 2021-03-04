Rails.application.routes.draw do
  get 'users/loggin'
  get 'users/signup'
  get 'users/update'
  get 'users/destroy'
  post '/loggin', to: 'users#loggin'
  post '/signup', to: 'users#create'
  resources :user, only: [:update, :destroy]
end
