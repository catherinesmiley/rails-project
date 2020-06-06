Rails.application.routes.draw do
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  resources :categories
  resources :songs
  resources :playlists
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
