Rails.application.routes.draw do
  devise_for :users
  resources :product_categories
  resources :products
  resources :categories
  root 'products#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
