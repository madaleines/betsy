Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :order_items, except: [:index] do
    resources :orders
  end

  resources :merchants, except: [:index] do
    resources :products
    resources :categories, only: [:new, :create]
  end

  resources :reviews, only: [:new, :create]
end
