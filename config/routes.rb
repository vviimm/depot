Rails.application.routes.draw do
  resources :line_items do
    put  'decrement', on: :member
    post 'decrement', on: :member
  end
  resources :carts
  resources :store
  resources :products
  root 'store#index'
end
