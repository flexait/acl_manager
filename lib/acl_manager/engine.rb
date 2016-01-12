module AclManager
  class Engine < ::Rails::Engine
    isolate_namespace AclManager

    initializer 'acl_manager.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper AclManager::AclsHelper
      end
    end
  end
end
