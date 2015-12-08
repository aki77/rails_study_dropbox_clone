Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :user_folders, only: %i(show create destroy edit update), path: 'folders' do
    resources :user_folders, only: %i(new), path: 'folders'
    resources :user_files, only: %i(new create destroy), path: 'files'
  end

  resources :user_files, only: %i(show), path: 'files'
end
