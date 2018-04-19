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

ActiveRecord::Schema.define(version: 20180413162221) do

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.string "email"
    t.string "login_id"
    t.integer "location_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "email"
    t.string "phone"
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

  create_table "search_areas", force: :cascade do |t|
    t.string "name"
    t.integer "location_id"
    t.boolean "primary", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_request_search_attempts", force: :cascade do |t|
    t.integer "search_request_id"
    t.integer "employee_id"
    t.string "resolution"
    t.string "found_location"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_requests", force: :cascade do |t|
    t.integer "patron_id"
    t.integer "location_id"
    t.integer "item_id"
    t.string "item_callnumber"
    t.string "item_title"
    t.text "note"
    t.string "resolution"
    t.string "status"
    t.integer "assigned_to_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
