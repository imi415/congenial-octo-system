Rails.application.routes.draw do
  resources :channels

  resources :users

  
  root to: 'lives#index'
  get '/live', to: 'lives#index'
  get '/live/:name', to: 'lives#show', as: 'live_play'

  get '/login', to: 'auth#login', as: 'login'
  post '/login', to: 'auth#authenticate', as: 'authenticate'

  get '/logout', to: 'auth#logout', as: 'logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
