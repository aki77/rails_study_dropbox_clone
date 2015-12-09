Rails.application.routes.draw do
  get 'user_items/search'

  devise_for :users
  root 'home#index'

  resources :user_folders, only: %i(show create destroy edit update), path: 'folders' do
    resources :user_folders, only: %i(new), path: 'folders'
    resources :user_files, only: %i(new create edit update destroy show), path: 'files' do
      member do
        get :download
        post :copy
        get :move
      end
    end
  end

  resources :events, only: %i(index)

  get 'search', to: 'user_items#search'
end
