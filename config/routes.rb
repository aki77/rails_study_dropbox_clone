Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :user_folders, only: %i(show create destroy edit update), path: 'folders' do
    resources :user_folders, only: %i(new), path: 'folders'
    resources :user_files, only: %i(new create edit update destroy show share), path: 'files' do
      member do
        get :download
        post :copy
        get :move
        get :share
      end
      resources :shared_files, only: %i(create destroy)
    end
  end

  resources :events, only: %i(index)
  resources :shared_files, only: %i(show) do
    member do
      get :download
    end
  end

  get 'search', to: 'user_items#search'
end
