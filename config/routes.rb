Rails.application.routes.draw do
  root :to => 'home#index'

  resources :forum_categories, only: [:create, :index, :show]
end
