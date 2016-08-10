class CreateAclsRoles < ActiveRecord::Migration
  def change
    create_join_table :acl_manager_acls, :acl_manager_roles, table_name: 'acl_manager_acls_roles' do |t|
      t.index [:acl_manager_acl_id, :acl_manager_role_id]
      t.index [:acl_manager_role_id, :acl_manager_acl_id]
    end
  end
end
