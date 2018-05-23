AclManager::Engine.routes.draw do
  root to: 'roles#index'

  resources :roles
  resources :acls do
    get 'build_all', on: :collection
  end
end
