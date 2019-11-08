# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#               user_shifts GET    /users/:user_id/shifts(.:format)                                                         shifts#index
#                           POST   /users/:user_id/shifts(.:format)                                                         shifts#create
#                     shift GET    /shifts/:id(.:format)                                                                    shifts#show
#                           PATCH  /shifts/:id(.:format)                                                                    shifts#update
#                           PUT    /shifts/:id(.:format)                                                                    shifts#update
#                           DELETE /shifts/:id(.:format)                                                                    shifts#destroy
#                     users GET    /users(.:format)                                                                         users#index
#                           POST   /users(.:format)                                                                         users#create
#                      user GET    /users/:id(.:format)                                                                     users#show
#                           PATCH  /users/:id(.:format)                                                                     users#update
#                           PUT    /users/:id(.:format)                                                                     users#update
#                           DELETE /users/:id(.:format)                                                                     users#destroy
#                    shifts GET    /shifts(.:format)                                                                        shifts#index
#                auth_login POST   /auth/login(.:format)                                                                    authentication#login
#               auth_signup POST   /auth/signup(.:format)                                                                   authentication#sign_up
#                           GET    /*a(.:format)                                                                            application#not_found
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
#
#
Rails.application.routes.draw do
  resources :users do
    resources :shifts, shallow: true
  end
  resources :shifts, only: [:index]
  post '/auth/login', to: 'authentication#login'
  post '/auth/signup', to: 'authentication#sign_up'
  get '/*a', to: 'application#not_found'
end
