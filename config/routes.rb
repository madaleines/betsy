Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'products#index', as: 'root'
  get "/auth/:provider/callback", to: "sessions#create", as: 'auth_callback'
  get '/cart', to: 'orders#index', as: 'cart'

  resources :orders, only: [:show, :create, :update, :destroy] do
    resources :order_items, except: [:index, :show, :edit]
  end

  resources :products, except: [:new, :create, :edit, :destroy] do
    resources :reviews, only: [:index, :new, :create]
  end

  resources :categories, except: [:destroy] do
    resources :products, only: [:index]
  end

  resources :merchants, except: [:index] do
    resources :products, only: [:new, :create, :edit]
  end

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'
end
