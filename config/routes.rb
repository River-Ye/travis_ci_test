Rails.application.routes.draw do
  resources :tasks
  resources :users
  root 'users#index'
end
