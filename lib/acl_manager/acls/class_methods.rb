module ClassMethods
	def acl_manager
		ancestors.first.class_eval do
			has_and_belongs_to_many :roles, 
		    class_name: AclManager::Role.name,
		    join_table: 'acl_manager_roles_users',
		    foreign_key: 'user_id', 
		    association_foreign_key: 'acl_manager_role_id'

	  	has_many :acls, through: :roles, class_name: AclManager::Acl.name
		end
	end
end