Rails.application.routes.draw do
  #jwt authentication
  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :category do
    resources :recipes
  end
end
