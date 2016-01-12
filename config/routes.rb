AclManager::Engine.routes.draw do
  resources :acls do
    get 'build_all', on: :collection
  end
  resources :roles

  resources :gils
end
