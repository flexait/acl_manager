Rails.application.routes.draw do

  namespace "gil" do

    resources :quens

  end


  mount AclManager::Engine => "/acl_manager"

  resources :denilsons

end
