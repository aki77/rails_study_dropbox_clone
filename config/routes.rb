Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :folders, only: %i(show new create), controller: 'user_items' do
    collection do
      get '', to: :root, as: 'root'
    end
  end
end
