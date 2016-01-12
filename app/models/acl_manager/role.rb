module AclManager
  class Role < ActiveRecord::Base
    has_and_belongs_to_many :acls, 
      class_name: AclManager::Acl.name, 
      join_table: 'acl_manager_acls_roles', 
      foreign_key: 'acl_manager_role_id', 
      association_foreign_key: 'acl_manager_acl_id'

    validates :name, presence: true
    validates :name, uniqueness: true

    default_scope { where(active: true) }

    def included? acl
      self.acl_ids.include?(acl.id)
    end

    def self.admin
      role = Role.find_or_create_by(name: 'admin', active: true)
      if role.acls.empty?
        role.acls << Acl.find_by(name: 'app', namespace: 'app')
        role.acls << Acl.find_by(name: 'devise', namespace: 'devise')
      end
      role
    end
  end
end
