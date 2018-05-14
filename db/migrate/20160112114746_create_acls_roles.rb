class CreateAclsRoles < ActiveRecord::Migration[4.2]
  def change
    create_join_table :acl_manager_acls, :acl_manager_roles, table_name: 'acl_manager_acls_roles' do |t|
      t.index [:acl_manager_acl_id, :acl_manager_role_id], name: 'idx_acl_role'
      t.index [:acl_manager_role_id, :acl_manager_acl_id], name: 'idx_role_acl'
    end
  end
end
