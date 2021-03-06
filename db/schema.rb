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

ActiveRecord::Schema.define(version: 20170308175556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.string   "user_type"
    t.string   "document_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "document_type"
    t.index ["user_id"], name: "index_bookmarks_on_user_id", using: :btree
  end

  create_table "checksum_audit_logs", force: :cascade do |t|
    t.string   "file_set_id"
    t.string   "file_id"
    t.string   "version"
    t.integer  "pass"
    t.string   "expected_result"
    t.string   "actual_result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["file_set_id", "file_id"], name: "by_file_set_id_and_file_id", using: :btree
  end

  create_table "curation_concerns_operations", force: :cascade do |t|
    t.string   "status"
    t.string   "operation_type"
    t.string   "job_class"
    t.string   "job_id"
    t.string   "type"
    t.text     "message"
    t.integer  "user_id"
    t.integer  "parent_id"
    t.integer  "lft",                        null: false
    t.integer  "rgt",                        null: false
    t.integer  "depth",          default: 0, null: false
    t.integer  "children_count", default: 0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["lft"], name: "index_curation_concerns_operations_on_lft", using: :btree
    t.index ["parent_id"], name: "index_curation_concerns_operations_on_parent_id", using: :btree
    t.index ["rgt"], name: "index_curation_concerns_operations_on_rgt", using: :btree
    t.index ["user_id"], name: "index_curation_concerns_operations_on_user_id", using: :btree
  end

  create_table "searches", force: :cascade do |t|
    t.text     "query_params"
    t.integer  "user_id"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_searches_on_user_id", using: :btree
  end

  create_table "single_use_links", force: :cascade do |t|
    t.string   "downloadKey"
    t.string   "path"
    t.string   "itemId"
    t.datetime "expires"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sipity_agents", force: :cascade do |t|
    t.string   "proxy_for_id",   null: false
    t.string   "proxy_for_type", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["proxy_for_id", "proxy_for_type"], name: "sipity_agents_proxy_for", unique: true, using: :btree
  end

  create_table "sipity_comments", force: :cascade do |t|
    t.integer  "entity_id",  null: false
    t.integer  "agent_id",   null: false
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_sipity_comments_on_agent_id", using: :btree
    t.index ["created_at"], name: "index_sipity_comments_on_created_at", using: :btree
    t.index ["entity_id"], name: "index_sipity_comments_on_entity_id", using: :btree
  end

  create_table "sipity_entities", force: :cascade do |t|
    t.string   "proxy_for_global_id", null: false
    t.integer  "workflow_id",         null: false
    t.integer  "workflow_state_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["proxy_for_global_id"], name: "sipity_entities_proxy_for_global_id", unique: true, using: :btree
    t.index ["workflow_id"], name: "index_sipity_entities_on_workflow_id", using: :btree
    t.index ["workflow_state_id"], name: "index_sipity_entities_on_workflow_state_id", using: :btree
  end

  create_table "sipity_entity_specific_responsibilities", force: :cascade do |t|
    t.integer  "workflow_role_id", null: false
    t.string   "entity_id",        null: false
    t.integer  "agent_id",         null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["agent_id"], name: "sipity_entity_specific_responsibilities_agent", using: :btree
    t.index ["entity_id"], name: "sipity_entity_specific_responsibilities_entity", using: :btree
    t.index ["workflow_role_id", "entity_id", "agent_id"], name: "sipity_entity_specific_responsibilities_aggregate", unique: true, using: :btree
    t.index ["workflow_role_id"], name: "sipity_entity_specific_responsibilities_role", using: :btree
  end

  create_table "sipity_notifiable_contexts", force: :cascade do |t|
    t.integer  "scope_for_notification_id",   null: false
    t.string   "scope_for_notification_type", null: false
    t.string   "reason_for_notification",     null: false
    t.integer  "notification_id",             null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["notification_id"], name: "sipity_notifiable_contexts_notification_id", using: :btree
    t.index ["scope_for_notification_id", "scope_for_notification_type", "reason_for_notification", "notification_id"], name: "sipity_notifiable_contexts_concern_surrogate", unique: true, using: :btree
    t.index ["scope_for_notification_id", "scope_for_notification_type", "reason_for_notification"], name: "sipity_notifiable_contexts_concern_context", using: :btree
    t.index ["scope_for_notification_id", "scope_for_notification_type"], name: "sipity_notifiable_contexts_concern", using: :btree
  end

  create_table "sipity_notification_recipients", force: :cascade do |t|
    t.integer  "notification_id",    null: false
    t.integer  "role_id",            null: false
    t.string   "recipient_strategy", null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["notification_id", "role_id", "recipient_strategy"], name: "sipity_notifications_recipients_surrogate", using: :btree
    t.index ["notification_id"], name: "sipity_notification_recipients_notification", using: :btree
    t.index ["recipient_strategy"], name: "sipity_notification_recipients_recipient_strategy", using: :btree
    t.index ["role_id"], name: "sipity_notification_recipients_role", using: :btree
  end

  create_table "sipity_notifications", force: :cascade do |t|
    t.string   "name",              null: false
    t.string   "notification_type", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["name"], name: "index_sipity_notifications_on_name", unique: true, using: :btree
    t.index ["notification_type"], name: "index_sipity_notifications_on_notification_type", using: :btree
  end

  create_table "sipity_roles", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_sipity_roles_on_name", unique: true, using: :btree
  end

  create_table "sipity_workflow_actions", force: :cascade do |t|
    t.integer  "workflow_id",                 null: false
    t.integer  "resulting_workflow_state_id"
    t.string   "name",                        null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["resulting_workflow_state_id"], name: "sipity_workflow_actions_resulting_workflow_state", using: :btree
    t.index ["workflow_id", "name"], name: "sipity_workflow_actions_aggregate", unique: true, using: :btree
    t.index ["workflow_id"], name: "sipity_workflow_actions_workflow", using: :btree
  end

  create_table "sipity_workflow_methods", force: :cascade do |t|
    t.string   "service_name",       null: false
    t.integer  "weight",             null: false
    t.integer  "workflow_action_id", null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["workflow_action_id"], name: "index_sipity_workflow_methods_on_workflow_action_id", using: :btree
  end

  create_table "sipity_workflow_responsibilities", force: :cascade do |t|
    t.integer  "agent_id",         null: false
    t.integer  "workflow_role_id", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["agent_id", "workflow_role_id"], name: "sipity_workflow_responsibilities_aggregate", unique: true, using: :btree
  end

  create_table "sipity_workflow_roles", force: :cascade do |t|
    t.integer  "workflow_id", null: false
    t.integer  "role_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["workflow_id", "role_id"], name: "sipity_workflow_roles_aggregate", unique: true, using: :btree
  end

  create_table "sipity_workflow_state_action_permissions", force: :cascade do |t|
    t.integer  "workflow_role_id",         null: false
    t.integer  "workflow_state_action_id", null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["workflow_role_id", "workflow_state_action_id"], name: "sipity_workflow_state_action_permissions_aggregate", unique: true, using: :btree
  end

  create_table "sipity_workflow_state_actions", force: :cascade do |t|
    t.integer  "originating_workflow_state_id", null: false
    t.integer  "workflow_action_id",            null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["originating_workflow_state_id", "workflow_action_id"], name: "sipity_workflow_state_actions_aggregate", unique: true, using: :btree
  end

  create_table "sipity_workflow_states", force: :cascade do |t|
    t.integer  "workflow_id", null: false
    t.string   "name",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_sipity_workflow_states_on_name", using: :btree
    t.index ["workflow_id", "name"], name: "sipity_type_state_aggregate", unique: true, using: :btree
  end

  create_table "sipity_workflows", force: :cascade do |t|
    t.string   "name",                null: false
    t.string   "label"
    t.text     "description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.boolean  "allows_access_grant"
    t.index ["name"], name: "index_sipity_workflows_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "guest",                  default: false
    t.text     "group_list"
    t.datetime "groups_list_expires_at"
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "version_committers", force: :cascade do |t|
    t.string   "obj_id"
    t.string   "datastream_id"
    t.string   "version_id"
    t.string   "committer_login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "curation_concerns_operations", "users"
end
