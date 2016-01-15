require "acl_manager/engine"
require 'acl_manager/acls/class_methods'
require 'acl_manager/acls/instance_methods'

module AclManager

  def self.included(base)
  	base.class_eval do
			extend ClassMethods
			include InstanceMethods
		end
	end	
end
