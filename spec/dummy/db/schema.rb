# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180522010256) do

  create_table "acl_manager_acls", force: :cascade do |t|
    t.string "name"
    t.string "namespace"
    t.string "controller"
    t.string "action"
    t.string "verb"
    t.string "helper"
    t.string "path"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "acl_manager_acls_roles", id: false, force: :cascade do |t|
    t.integer "acl_manager_acl_id", null: false
    t.integer "acl_manager_role_id", null: false
    t.index ["acl_manager_acl_id", "acl_manager_role_id"], name: "acl_manager_acl_role"
    t.index ["acl_manager_role_id", "acl_manager_acl_id"], name: "acl_manager_role_acl"
  end

  create_table "acl_manager_roles", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "acl_manager_roles_users", id: false, force: :cascade do |t|
    t.integer "acl_manager_role_id", null: false
    t.integer "user_id", null: false
    t.index ["acl_manager_role_id", "user_id"], name: "acl_manager_join_role_user"
    t.index ["user_id", "acl_manager_role_id"], name: "acl_manager_join_user_acl"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
