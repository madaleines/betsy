Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://g
  resources :orders, only: [:show, :create, :update, :destroy] do
    resources :order_items, except: [:index, :show]
  end

  get '/cart', to: 'orders#index', as: 'cart'

  resources :products, except: [:new, :create, :destroy] do

    resources :reviews, only: [:index, :new, :create]
  end


  resources :categories, except: [:destroy] do
    resources :products, only: [:index]
  end

  resources :merchants, except: [:index] do
    resources :products, only: [:new, :create]
  end

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'
end
