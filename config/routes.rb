Rails.application.routes.draw do
  devise_for :users
  resources :admins, only: %i[edit index]

  resources :orders

  post 'orders/new', to: 'orders#create'

  resources :users, only: %i[destroy edit update put]

  resources :items, only: %i[index new edit create update destroy]

  post 'items/search', to: 'items#search'

  get 'items/search', to: 'items#index'

  root 'pages#index'
end
