Rails.application.routes.draw do
  root to: 'home#index'

  resources :forum_categories
  resources :forum_threads
  resources :forum_posts
  resources :users
end
 
