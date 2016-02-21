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

ActiveRecord::Schema.define(version: 20160221013725) do

  create_table "layouts", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "template_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "layouts", ["name"], name: "index_layouts_on_name", unique: true
  add_index "layouts", ["template_id"], name: "index_layouts_on_template_id"

  create_table "pages", force: :cascade do |t|
    t.string   "uid",        null: false
    t.string   "title",      null: false
    t.integer  "parent_id"
    t.integer  "view_id"
    t.integer  "slug_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pages", ["parent_id"], name: "index_pages_on_parent_id"
  add_index "pages", ["slug_id"], name: "index_pages_on_slug_id", unique: true
  add_index "pages", ["title"], name: "index_pages_on_title", unique: true
  add_index "pages", ["uid"], name: "index_pages_on_uid", unique: true
  add_index "pages", ["view_id"], name: "index_pages_on_view_id"

  create_table "partials", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "template_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "partials", ["name"], name: "index_partials_on_name", unique: true
  add_index "partials", ["template_id"], name: "index_partials_on_template_id"

  create_table "setting_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "setting_types", ["name"], name: "index_setting_types_on_name", unique: true

  create_table "settings", force: :cascade do |t|
    t.string   "key",             null: false
    t.string   "value"
    t.integer  "setting_type_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "settings", ["key"], name: "index_settings_on_key"
  add_index "settings", ["setting_type_id", "key"], name: "index_settings_on_setting_type_id_and_key", unique: true
  add_index "settings", ["setting_type_id"], name: "index_settings_on_setting_type_id"
  add_index "settings", ["value"], name: "index_settings_on_value"

  create_table "slugs", force: :cascade do |t|
    t.string   "uri"
    t.string   "sluggable_type"
    t.integer  "sluggable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "slugs", ["sluggable_id", "sluggable_type"], name: "index_slugs_on_sluggable_id_and_sluggable_type", unique: true
  add_index "slugs", ["sluggable_id"], name: "index_slugs_on_sluggable_id"
  add_index "slugs", ["sluggable_type"], name: "index_slugs_on_sluggable_type"
  add_index "slugs", ["uri"], name: "index_slugs_on_uri", unique: true

  create_table "template_file_types", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "extension",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "template_file_types", ["extension"], name: "index_template_file_types_on_extension", unique: true
  add_index "template_file_types", ["name"], name: "index_template_file_types_on_name", unique: true

  create_table "template_layouts", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "template_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "template_layouts", ["name"], name: "index_template_layouts_on_name", unique: true
  add_index "template_layouts", ["template_id"], name: "index_template_layouts_on_template_id"

  create_table "templates", force: :cascade do |t|
    t.text     "body"
    t.string   "templateable_type"
    t.integer  "templateable_id"
    t.integer  "template_file_type_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "templates", ["template_file_type_id"], name: "index_templates_on_template_file_type_id"
  add_index "templates", ["templateable_id", "templateable_type"], name: "index_templates_on_templateable_id_and_templateable_type", unique: true
  add_index "templates", ["templateable_id"], name: "index_templates_on_templateable_id"
  add_index "templates", ["templateable_type"], name: "index_templates_on_templateable_type"

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "auth_token",      null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "views", force: :cascade do |t|
    t.string   "viewable_type"
    t.integer  "viewable_id"
    t.integer  "template_layout_id"
    t.integer  "template_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "views", ["template_id"], name: "index_views_on_template_id"
  add_index "views", ["template_layout_id"], name: "index_views_on_template_layout_id"
  add_index "views", ["viewable_id", "viewable_type"], name: "index_views_on_viewable_id_and_viewable_type", unique: true
  add_index "views", ["viewable_id"], name: "index_views_on_viewable_id"
  add_index "views", ["viewable_type"], name: "index_views_on_viewable_type"

end
