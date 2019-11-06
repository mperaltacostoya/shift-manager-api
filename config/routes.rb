Rails.application.routes.draw do
  resources :users
  post '/auth/login', to: 'authentication#login'
  post '/auth/signup', to: 'authentication#sign_up'
  get '/*a', to: 'application#not_found'
end
