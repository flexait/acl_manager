# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160112120233) do

  create_table "acl_manager_acls", force: :cascade do |t|
    t.string   "name"
    t.string   "namespace"
    t.string   "controller"
    t.string   "action"
    t.string   "verb"
    t.string   "helper"
    t.string   "path"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "acl_manager_acls_roles", force: :cascade do |t|
    t.integer "acl_manager_acl_id"
    t.integer "acl_manager_role_id"
  end

  add_index "acl_manager_acls_roles", ["acl_manager_acl_id"], name: "index_acl_manager_acls_roles_on_acl_manager_acl_id"
  add_index "acl_manager_acls_roles", ["acl_manager_role_id"], name: "index_acl_manager_acls_roles_on_acl_manager_role_id"

  create_table "acl_manager_roles", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
