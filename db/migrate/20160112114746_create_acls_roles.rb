class CreateAclsRoles < ActiveRecord::Migration
  def change
    create_table :acl_manager_acls_roles do |t|
      t.references :acl_manager_acl, index: true
      t.references :acl_manager_role, index: true
    end

    add_foreign_key :acl_manager_acls_roles, :acl_manager_acls
    add_foreign_key :acl_manager_acls_roles, :acl_manager_roles
  end
end
