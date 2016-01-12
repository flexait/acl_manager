Rails.application.routes.draw do

  resources :users

  mount AclManager::Engine => "/acl_manager"

  resources :denilsons

end
