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

ActiveRecord::Schema.define(version: 20140318191520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: true do |t|
    t.date     "date"
    t.integer  "week_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "businesses", ["week_id"], name: "index_businesses_on_week_id", using: :btree

  create_table "employees", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.datetime "monstart"
    t.datetime "monfinish"
    t.datetime "tuestart"
    t.datetime "tuefinish"
    t.datetime "wedstart"
    t.datetime "wedfinish"
    t.datetime "thurstart"
    t.datetime "thurfinish"
    t.datetime "fristart"
    t.datetime "frifinish"
    t.datetime "satstart"
    t.datetime "satfinish"
    t.datetime "sunstart"
    t.datetime "sunfinish"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "desired"
  end

  create_table "leaves", force: true do |t|
    t.datetime "start"
    t.datetime "finish"
    t.integer  "employee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "leaves", ["employee_id"], name: "index_leaves_on_employee_id", using: :btree

  create_table "observers", force: true do |t|
    t.integer  "schedule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  add_index "observers", ["schedule_id"], name: "index_observers_on_schedule_id", using: :btree

  create_table "rosterings", force: true do |t|
    t.integer  "employee_id"
    t.integer  "schedule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.integer  "week_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["week_id"], name: "index_schedules_on_week_id", using: :btree

  create_table "shifts", force: true do |t|
    t.datetime "start"
    t.datetime "finish"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "minutes"
    t.integer  "shiftable_id"
    t.string   "shiftable_type"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.text     "profile"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weeks", force: true do |t|
    t.date     "start"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
