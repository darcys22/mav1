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

ActiveRecord::Schema.define(version: 20140216172111) do

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
  end

end
