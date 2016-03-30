module AclManager
  module Permissions
    def permit! acl
      self.acls.permit!(acl)
    end
  end
end
