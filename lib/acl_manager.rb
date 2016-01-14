require "acl_manager/engine"

module AclManager
	autoload :ClassMethods, 'acl_manager/acls/class_methods'
	autoload :InstanceMethods, 'acl_manager/acls/instance_methods'

  def self.included(base)
		base.extend ClassMethods
		base.include InstanceMethods
	end	
end
