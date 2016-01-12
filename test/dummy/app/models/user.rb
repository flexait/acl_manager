class User < ActiveRecord::Base
	include AclManager
	acl_manager
end
