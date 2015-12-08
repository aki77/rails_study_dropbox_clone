Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :user_folders, only: %i(show create destroy), path: 'folders' do
    resources :user_folders, only: %i(new), path: 'folders'
  end
end
