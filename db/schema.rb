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

ActiveRecord::Schema.define(version: 20190124192109) do

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
    t.string "ils_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default_location", default: false
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

  create_table "search_ticket_searched_areas", force: :cascade do |t|
    t.integer "search_area_id"
    t.integer "work_log_id"
    t.integer "search_ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_ticket_work_logs", force: :cascade do |t|
    t.integer "search_ticket_id"
    t.integer "employee_id"
    t.string "result"
    t.string "found_location"
    t.text "note"
    t.string "work_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_tickets", force: :cascade do |t|
    t.integer "patron_id"
    t.integer "location_id"
    t.string "item_id"
    t.string "item_callnumber"
    t.string "item_title"
    t.string "item_author"
    t.string "item_volume"
    t.string "item_issue"
    t.string "item_year"
    t.string "item_location"
    t.text "note"
    t.string "resolution"
    t.string "status"
    t.integer "assigned_to_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
