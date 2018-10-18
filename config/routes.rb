Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :orders only: [:show, :create, :update, :destroy] do
    resources :order_items, except: [:index, :show]
  end

  get '/cart', to: 'orders#index', as: 'cart'

  resources :merchants, except: [:index] do
    resources :products, except: [:destroy]
    resources :categories, only: [:new, :create]
  end

  resources :reviews, only: [:new, :create]

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'
end
