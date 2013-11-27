RailsPostit::Application.routes.draw do
  root "pages#home"
  get "about" => "pages#about"

  resources :posts, except: [:destroy] do
    resources :comments, only:[:create]
  end



  resources :categories, only:[:new, :create]
end
