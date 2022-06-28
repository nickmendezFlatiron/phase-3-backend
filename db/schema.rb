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

ActiveRecord::Schema.define(version: 2022_06_28_203656) do

  create_table "appointments", force: :cascade do |t|
    t.time "time"
    t.date "date"
    t.integer "walk_duration"
    t.integer "dog_id"
    t.integer "employee_id"
    t.index ["dog_id"], name: "index_appointments_on_dog_id"
    t.index ["employee_id"], name: "index_appointments_on_employee_id"
  end

  create_table "dogs", force: :cascade do |t|
    t.string "dog_name"
    t.string "dog_image"
    t.integer "dog_weight"
    t.integer "owner_id"
    t.index ["owner_id"], name: "index_dogs_on_owner_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "employee_name"
    t.text "address"
    t.string "phone_number"
    t.integer "wage"
    t.integer "hours_worked"
    t.string "position"
  end

  create_table "owners", force: :cascade do |t|
    t.string "owner_name"
    t.string "phone_number"
    t.string "email"
    t.text "address"
  end

  add_foreign_key "appointments", "dogs"
  add_foreign_key "appointments", "employees"
  add_foreign_key "dogs", "owners"
end
