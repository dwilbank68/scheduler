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

ActiveRecord::Schema.define(version: 20141209024521) do

  create_table "unit_users", force: true do |t|
    t.integer "unit_id"
    t.integer "user_id"
  end

  add_index "unit_users", ["unit_id"], name: "index_unit_users_on_unit_id"
  add_index "unit_users", ["user_id"], name: "index_unit_users_on_user_id"

  create_table "units", force: true do |t|
    t.string   "name"
    t.string   "screenName"
    t.string   "position"
    t.string   "imagePath"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "SMS"
    t.string   "email"
    t.datetime "start_time"
    t.integer  "duration"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
