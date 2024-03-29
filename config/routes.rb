Rails.application.routes.draw do
  get 'children/index'
  resources :investments, only: [:new, :create, :index, :show] do
    post 'release', on: :member
  end

  resources :childrens, only: :index

  get 'wallets/:id', to: 'wallets#show', as: 'wallet'

  resources :wallets do
    member do
      get :export_investments_to_csv
      get :export_investments_to_json

      get :export_profits_to_csv
      get :export_profits_to_json

      get :export_releases_to_csv
      get :export_releases_to_json
    end
  end

  resources :cryptocurrencies do
    collection do
      get 'export_csv'
      get 'export_json'
    end
  end
  root "cryptocurrencies#index"
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
