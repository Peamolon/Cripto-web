Rails.application.routes.draw do
  get 'children/index'
  resources :investments, only: [:new, :create, :index, :show]
  resources :childrens, only: :index

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
