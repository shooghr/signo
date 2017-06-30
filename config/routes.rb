Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  resources :accesses
  devise_for :users

  resources :users do
    member do
      resources :notifications
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
