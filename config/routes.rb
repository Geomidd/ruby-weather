Rails.application.routes.draw do
  root 'home#index'
  
  # get 'zipcode' => 'home#zipcode'
  # post 'zipcode' => 'home#zipcode'
  match "zipcode" => 'home#zipcode', via: [:get]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
