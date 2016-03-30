Rails.application.routes.draw do

  resources :photos

  match '/admin',  to: 'admin#index',      via: 'get'
  match '/login',  to: 'sessions#new',     via: 'get'
  match '/login',  to: 'sessions#create',  via: 'post'
  match '/logout', to: 'sessions#destroy', via: 'delete'

  match 'upload/get',  to: 'upload#get',   via: 'get'
  match 'upload/save', to: 'upload#save',  via: 'get'
  match 'upload/show', to: 'upload#show',  via: 'get'

  resources :users
  resources :products do
    get :who_bought, on: :member
  end

  scope '(:locale)' do
    resources :orders
    resources :line_items do
      put  'decrement', on: :member
      post 'decrement', on: :member
    end
    resources :carts
    root 'store#index', as: 'store', via: :all
  end
end
