Rails.application.routes.draw do
  resources :investments, only: [:new, :create]

  resources :cryptocurrencies do
    collection do
      get 'export_csv'
      get 'export_json'
    end
  end
  root "cryptocurrencies#index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
