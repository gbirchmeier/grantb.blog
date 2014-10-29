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

ActiveRecord::Schema.define(version: 20141029145902) do

  create_table "post_tags", force: true do |t|
    t.integer "post_id", null: false
    t.integer "tag_id",  null: false
  end

  add_index "post_tags", ["post_id"], name: "index_post_tags_on_post_id", using: :btree
  add_index "post_tags", ["tag_id"], name: "index_post_tags_on_tag_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "headline",                          null: false
    t.text     "content",                           null: false
    t.datetime "published_at"
    t.integer  "user_id",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "markup_type",  default: "markdown", null: false
    t.string   "nice_url",                          null: false
  end

  add_index "posts", ["nice_url"], name: "index_posts_on_nice_url", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string "name", null: false
  end

  create_table "users", force: true do |t|
    t.string   "username",               null: false
    t.string   "email",                  null: false
    t.string   "password_digest"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "auth_token"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
