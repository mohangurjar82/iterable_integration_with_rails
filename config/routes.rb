Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users

  root 'events#index'
  post '/create_event_a', to: 'events#create_event_a'
  post '/create_event_b', to: 'events#create_event_b'
end