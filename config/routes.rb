Rails.application.routes.draw do

  # Purchases upload
  get 'purchases', to: 'purchases#index'
  post '/purchases/upload', to: 'purchases#upload'

  # Authentication
  get '/authenticate', to: 'sessions#new', as: :auth_confirm
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'
  get '/auth/failure', to: 'sessions#failure'

  root 'purchases#index'

end
