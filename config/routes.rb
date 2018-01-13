Rails.application.routes.draw do
  resources :picks do
    collection do
      post 'import'
    end
  end
  resources :posts
  devise_for :users
  root 'welcome#index'

  namespace :admin do
    root "posts#index"
    resources :users
    resources :posts
  end

  namespace :api do
    resource :posts
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
