Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
     resources :products, only: [:index, :show, :create]
    end
  end
  devise_for :users
  resources :users
  resources :friends


  get 'home/about'
  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
  