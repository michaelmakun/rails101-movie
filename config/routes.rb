Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :movies do
    resources :reviews
    member do
      post :favorite
      post :unlike
    end
  end

  namespace :account do
    resources :reviews
    resources :movies
  end
  root 'movies#index'
end
