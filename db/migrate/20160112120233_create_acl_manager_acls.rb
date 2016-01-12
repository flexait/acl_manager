class CreateAclManagerAcls < ActiveRecord::Migration
  def change
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
  end
end
