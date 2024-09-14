Rails.application.routes.draw do
  get "/users/:id/timeline", to: "users#timeline"
  post "/login", to: "authentication#login"
  post "/register", to: "users#create"

  resources :posts, only: [:create, :index, :show] do
    resources :comments, only: [:create, :index, :show]
  end

  resources :user_ratings, only: [:create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
