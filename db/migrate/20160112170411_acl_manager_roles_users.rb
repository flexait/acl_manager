class AclManagerRolesUsers < ActiveRecord::Migration[4.2]
  def change
    create_join_table :acl_manager_roles, :users do |t|
      t.index [:acl_manager_role_id, :user_id], name: 'idx_role_user'
      t.index [:user_id, :acl_manager_role_id], name: 'idx_user_role'
    end
  end
end
