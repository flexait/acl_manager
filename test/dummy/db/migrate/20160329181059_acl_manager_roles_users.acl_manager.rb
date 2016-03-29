# This migration comes from acl_manager (originally 20160112170411)
class AclManagerRolesUsers < ActiveRecord::Migration
  def change
    create_table :acl_manager_roles_users do |t|
      t.references :user, index: true
      t.references :acl_manager_role, index: true
    end

    add_foreign_key :acl_manager_roles_users, :users
    add_foreign_key :acl_manager_roles_users, :acl_manager_roles
  end
end
