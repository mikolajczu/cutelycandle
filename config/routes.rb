Rails.application.routes.draw do
  devise_for :users

  resources :product_categories
  resources :products
  resources :categories

  root 'products#index'

  resources :webhooks, only: [:create]
  post 'checkout/create', to: 'checkout#create'
  get "success", to: "checkout#success"
  get "cancel", to: "checkout#cancel"
  post "products/add_to_cart/:id", to: "products#add_to_cart", as: "add_to_cart"
  delete "products/remove_from_cart/:id", to: "products#remove_from_cart", as: "remove_from_cart"
  post "checkout/shoppingcart", to: "checkout#shoppingcart"
  get "checkout/shoppingcart", to: "checkout#shoppingcart"
  post "checkout/clear", to: "checkout#clear"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
