Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  root to: 'tasks#index'
  resources :sessions, only: %w!new create destroy!
  
  resources :tasks 
end
