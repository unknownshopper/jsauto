Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'tickets#index', as: :authenticated_root
    resources :tickets
  end

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
