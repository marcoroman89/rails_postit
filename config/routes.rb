RailsPostit::Application.routes.draw do
  root "pages#home"
  get "about" => "pages#about"

  get "/register", to: "users#new" # Display of registration page
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  resources :users, only: [:create] # Submission fo the form

  resources :posts, except: [:destroy] do
    resources :comments, only:[:create]
  end



  resources :categories, only:[:new, :create]
end
