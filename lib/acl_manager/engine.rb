Gem.loaded_specs['acl_manager'].dependencies.each do |d|
 require d.name
end

module AclManager
  class Engine < ::Rails::Engine
    isolate_namespace AclManager

  end
end
