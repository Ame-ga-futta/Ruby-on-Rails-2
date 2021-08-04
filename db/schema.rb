# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_02_042524) do

  create_table "reservations", force: :cascade do |t|
    t.integer "room_id"
    t.integer "user_id"
    t.date "start_date"
    t.date "end_date"
    t.integer "people"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "room_image"
    t.string "room_name"
    t.string "room_introduction"
    t.integer "room_total_price"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.string "introduction"
    t.integer "price"
    t.string "address"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_confirmation"
    t.string "icon"
    t.string "introduction"
    t.string "password_reset"
    t.string "password_reset_confirmation"
  end

end
