Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  root to: 'home#index'

  resources :forum_categories
  resources :forum_threads
  resources :forum_posts
  resources :users
  resources :articles
  resources :password_resets, only: [:new, :create, :edit, :update]
end
