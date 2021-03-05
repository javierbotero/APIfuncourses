Rails.application.routes.draw do
  get 'courses/index'
  get 'courses/create'
  get 'courses/update'
  get 'courses/delete'
  post '/loggin', to: 'users#loggin'
  post '/signup', to: 'users#create'
  resources :users, only: [:update, :destroy]
end
