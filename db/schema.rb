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

ActiveRecord::Schema.define(version: 2022_06_01_034421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.string "projectName"
    t.string "projectPet"
    t.integer "petHealth"
    t.integer "petLevel"
    t.string "projectGitHub"
    t.string "petImage"
    t.hstore "stats", default: {"totalWorkTime"=>"0", "totalLongPomTime"=>"0", "totalLongSessions"=>"0", "totalShortPomTime"=>"0", "totalWorkSessions"=>"0", "totalShortSessions"=>"0"}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "profilePhoto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore "settings", default: {"workTime"=>"0", "longPomTime"=>"0", "shortPomTime"=>"0"}, null: false
  end

  add_foreign_key "projects", "users"
end
