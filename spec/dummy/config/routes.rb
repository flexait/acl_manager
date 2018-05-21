Rails.application.routes.draw do
  mount AclManager::Engine, at: 'acl_manager'
end
