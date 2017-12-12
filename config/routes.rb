Rails.application.routes.draw do
  resources :channels

  get "/live", to: 'lives#index'
  get '/live/:name', to: 'lives#show', as: 'live_play'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
