Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :user_folders, only: %i(show destroy edit update), path: 'folders' do
    member do
      get :move
    end

    resources :user_folders, only: %i(new create), path: 'folders'
    resources :user_files, only: %i(new create edit update destroy show), path: 'files' do
      member do
        get :download
        post :copy
        get :move
        get :share
        get :preview
      end
      resources :shared_files, only: %i(create)
    end
  end

  resources :events, only: %i(index)
  resources :shared_files, only: %i(show destroy) do
    member do
      get :download
      get :preview
    end
  end

  get 'search', to: 'user_items#search'
end
