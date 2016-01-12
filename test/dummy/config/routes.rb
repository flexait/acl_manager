Rails.application.routes.draw do

  resources :quens


  mount AclManager::Engine => "/acl_manager"

  resources :denilsons

end
