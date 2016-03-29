require "acl_manager/engine"

module AclManager
  autoload :Builder, 'acl_manager/builder'
  autoload :Filter, 'acl_manager/filter'
  autoload :RouteExtractor, 'acl_manager/route_extractor'

  def self.included(base)
  	base.extend ClassMethods
		base.include InstanceMethods
	end

  module ClassMethods
    def acl_manager
      has_and_belongs_to_many :roles,
      class_name: AclManager::Role.name,
      join_table: 'acl_manager_roles_users',
      foreign_key: 'user_id',
      association_foreign_key: 'acl_manager_role_id'

      has_many :acls, through: :roles, class_name: AclManager::Acl.name
    end
  end

  module InstanceMethods
    def permit! acl
      self.acls.permit!(acl)
    end
  end
end



ActiveSupport.on_load(:action_controller) do
  Devise.mappings.keys.each do |resource_name|
    define_method "authorizate_#{resource_name}!" do
      self.send("authenticate_#{resource_name}!")
      AclManager::Filter.before(self)
    end
  end
end
