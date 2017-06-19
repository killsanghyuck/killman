Rails.application.routes.draw do
  resources :posts
  devise_for :users
  root 'welcome#index'

  namespace :admin do
    root "users#index"
    resources :users
    end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
