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

ActiveRecord::Schema.define(version: 20180201141450) do

  create_table "missing_item_reports", force: :cascade do |t|
    t.integer "patron_id"
    t.integer "location_id"
    t.integer "item_id"
    t.string "item_callnumber"
    t.string "item_title"
    t.text "note"
    t.string "resolution"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patrons", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "login_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
