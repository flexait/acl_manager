class CreateAclManagerRoles < ActiveRecord::Migration
  def change
    create_table :acl_manager_roles do |t|
      t.string :name
      t.boolean :active
      t.string :description

      t.timestamps null: false
    end
  end
end
