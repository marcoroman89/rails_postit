RailsPostit::Application.routes.draw do
  root "pages#home"

  get "about" => "pages#about"
  resources :posts, except: [:destroy]

  resources :categories, only:[:new, :create]
end
