Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :user_folders, only: %i(show new create destroy), path: 'folders' do
    collection do
      get '', to: :root, as: 'root'
    end

    resources :user_folders, only: %i(new), path: 'folders'
  end
end
