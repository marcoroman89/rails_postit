RailsPostit::Application.routes.draw do
  root "pages#home"
    get "about" => "pages#about" # Creates about path
end
