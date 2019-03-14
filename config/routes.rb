# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments
  end
  root 'posts#index'
  namespace :api do
    namespace :v1 do
      resources :posts
    end
  end
end
