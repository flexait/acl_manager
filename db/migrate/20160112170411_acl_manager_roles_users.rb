class AclManagerRolesUsers < ActiveRecord::Migration
  def change
    create_join_table :acl_manager_roles, :users do |t|
      t.index [:acl_manager_role_id, :user_id]
      t.index [:user_id, :acl_manager_role_id]
    end
  end
end
