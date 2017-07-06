Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  resources :accesses
  devise_for :users

  resources :notifications, only: %i[index new create update]

  resources :users do
    member do
      resources :notifications do
        collection do
          get 'mark_all_read' => 'notifications#mark_all_read'
        end
        member do
          get 'redirect' => 'notifications#redirect'
          get 'mark_as_read' => 'notifications#mark_as_read'
        end
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
