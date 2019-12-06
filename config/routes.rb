Rails.application.routes.draw do
  root to: 'tasks#toppage'
  resources :users
  resources :sessions, only: %w!new create destroy!
  
  resources :tasks 
end
