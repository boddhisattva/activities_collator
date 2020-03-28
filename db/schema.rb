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

ActiveRecord::Schema.define(version: 2020_03_28_092114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "start", null: false
    t.datetime "finish", null: false
    t.text "description"
    t.text "url", null: false
    t.bigint "web_source_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["finish"], name: "index_events_on_finish"
    t.index ["start"], name: "index_events_on_start"
    t.index ["title"], name: "index_events_on_title"
    t.index ["url"], name: "index_events_on_url", unique: true
    t.index ["web_source_id"], name: "index_events_on_web_source_id"
  end

  create_table "web_sources", force: :cascade do |t|
    t.text "url", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "scraper"
    t.index ["url"], name: "index_web_sources_on_url", unique: true
  end

  add_foreign_key "events", "web_sources"
end
