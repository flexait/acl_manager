Gem.loaded_specs['acl_manager'].dependencies.each do |d|
 require d.name
end

module AclManager
  class Engine < ::Rails::Engine
    isolate_namespace AclManager
    initializer :append_migrations do |app|
		  unless app.root.to_s.match(root.to_s)
  			config.paths["db/migrate"].expanded.each do |p|
  				app.config.paths["db/migrate"] << p
  			end
  		end
	  end
    initializer :load_config_initializers do |app|
      ActiveRecord::Base.send(:include, AclManager)
    end

    ActiveSupport.on_load(:action_controller) do
      Devise.mappings.keys.each do |resource_name|
        define_method "authorizate_#{resource_name}!" do
          self.send("authenticate_#{resource_name}!")
          AclManager::Filter.before(self)
        end
      end
    end
  end
end
