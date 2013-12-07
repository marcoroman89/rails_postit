RailsPostit::Application.routes.draw do
  root "pages#home"
  get "about" => "pages#about"

  get "/register", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  resources :users, only: [:create, :edit, :update]

  resources :posts, except: [:destroy] do
    member do
      post 'vote'
    end

    resources :comments, only:[:create, :edit, :update] do
      member do
        post 'vote'
      end
    end
  end

  resources :categories, only:[:new, :create, :show]
end
