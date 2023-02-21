Rails.application.routes.draw do
  devise_for :users
  resources :friends


  get 'home/about'
  root "friends#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
  