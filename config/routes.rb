Rails.application.routes.draw do
  resources :accesses
  devise_for :users
  resources :notifications
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
