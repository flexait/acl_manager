class AddAclManagerToUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :acl_manager_roles do |t|
      t.string :name
      t.boolean :active
      t.string :description

      t.timestamps null: false
    end

    create_join_table :acl_manager_acls, :acl_manager_roles, table_name: 'acl_manager_acls_roles' do |t|
      t.index [:acl_manager_acl_id, :acl_manager_role_id], name: 'acl_manager_acl_role'
      t.index [:acl_manager_role_id, :acl_manager_acl_id], name: 'acl_manager_role_acl'
    end

    create_table :acl_manager_acls do |t|
      t.string :name
      t.string :namespace
      t.string :controller
      t.string :action
      t.string :verb
      t.string :helper
      t.string :path
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt

      t.timestamps null: false
    end

    create_join_table :acl_manager_roles, :users do |t|
      t.index [:acl_manager_role_id, :user_id], name: 'acl_manager_join_role_user'
      t.index [:user_id, :acl_manager_role_id], name: 'acl_manager_join_user_acl'
    end
  end
end
