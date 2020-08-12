Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  namespace :tweets do  #
  resources :searches, only: :index
  end
  resources :tweets do
    resources :comments, only: :create
    collection do  # この行は削除する
      get 'search'  # この行は削除する
    end  # この行は削除する
  end
  resources :users, only: :show
end