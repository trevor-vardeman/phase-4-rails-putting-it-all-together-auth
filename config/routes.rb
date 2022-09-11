Rails.application.routes.draw do
  resources :users, only: [:show, :create]
  resources :recipes, only: [:index, :create]

  get "/me", to: "users#show"
  post "/signup", to: "users#create"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "/recipes", to: "recipes#create"
end