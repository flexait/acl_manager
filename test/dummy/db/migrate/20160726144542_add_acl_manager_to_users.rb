class AddAclManagerToUsers < ActiveRecord::Migration
  def change
    create_table :acl_manager_roles do |t|
      t.string :name
      t.boolean :active
      t.string :description

      t.timestamps null: false
    end

    create_table :acl_manager_acls_roles do |t|
      t.references :acl_manager_acl, index: true
      t.references :acl_manager_role, index: true
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

    create_table :acl_manager_roles_users do |t|
      t.references :user, index: true
      t.references :acl_manager_role, index: true

      t.timestamps null: false
    end

    add_foreign_key :acl_manager_acls_roles, :acl_manager_acls
    add_foreign_key :acl_manager_acls_roles, :acl_manager_roles
    add_foreign_key :acl_manager_roles_users, :users
    add_foreign_key :acl_manager_roles_users, :acl_manager_roles
  end
end
