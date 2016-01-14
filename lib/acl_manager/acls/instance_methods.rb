module InstanceMethods
	def permit! acl
    self.acls.permit!(acl)
  end
end