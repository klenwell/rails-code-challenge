Rails.application.routes.draw do

  # Purchases upload
  get 'purchases', to: 'index'
  post '/purchases/upload', to: 'purchases#upload'

  # Authentication
  get '/authenticate', to: 'sessions#new', as: :auth_confirm
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  root 'purchases#index'

end
