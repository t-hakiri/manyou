Rails.application.routes.draw do
  root to: 'tasks#toppage'
  resources :users
  resources :labels
  
  namespace :admin do
    resources :users
  end

  resources :sessions, only: %w!new create destroy!  
  resources :tasks 
end
