Rails.application.routes.draw do

  get 'purchases', to: 'purchases#index'
  post '/purchases/upload', to: 'purchases#upload'

  root 'purchases#index'

end
