Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :sessions, only: %w!new create destroy!
  
  resources :tasks 
end
