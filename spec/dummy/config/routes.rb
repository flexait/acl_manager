Rails.application.routes.draw do
  devise_for :users
  resources :users
  mount AclManager::Engine, at: 'acl_manager'
end
