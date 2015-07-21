Rails.application.routes.draw do

  get 'purchases', to: 'index'
  post '/purchases/upload', to: 'purchases#upload'

  # Authentication paths
  get '/authenticate', to: 'sessions#new', as: :auth_confirm
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  root 'purchases#index'

end
