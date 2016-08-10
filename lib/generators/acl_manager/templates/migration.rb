class AddAclManagerTo<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    create_table :acl_manager_roles do |t|
      t.string :name
      t.boolean :active
      t.string :description

      t.timestamps null: false
    end

    create_join_table :acl_manager_acls, :acl_manager_roles, table_name: 'acl_manager_acls_roles' do |t|
      t.index [:acl_manager_acl_id, :acl_manager_role_id]
      t.index [:acl_manager_role_id, :acl_manager_acl_id]
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

    create_join_table :acl_manager_roles, :<%= table_name %> do |t|
      t.index [:acl_manager_role_id, :<%= table_name.singularize %>_id]
      t.index [:<%= table_name.singularize %>_id, :acl_manager_role_id]
    end
  end
end
