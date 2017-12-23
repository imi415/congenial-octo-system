Rails.application.routes.draw do
  resources :channels

  resources :users

  
  root to: 'lives#index'
  get '/live', to: 'lives#index'
  get '/live/:name', to: 'lives#show', as: 'live_play'

  get '/login', to: 'auth#login'
  post '/login', to: 'auth#authenticate', as: 'authenticate'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
