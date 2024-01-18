Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'dogs#search'
  post 'fetch_dog' => 'dogs#fetch_dog'
end
