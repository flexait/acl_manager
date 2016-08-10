Rails.application.routes.draw do
  mount AclManager::Engine, at: 'acl_manager'

  devise_for :users
  resources :users
end
