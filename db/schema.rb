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

ActiveRecord::Schema[7.0].define(version: 2023_04_04_113931) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "add_on_books", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "amount"
    t.bigint "booking_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_add_on_books_on_booking_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "barangay"
    t.string "city"
    t.string "province"
    t.integer "postal_code"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "adds_ons", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "amount"
    t.bigint "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_adds_ons_on_service_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.date "check_out"
    t.bigint "user_id", null: false
    t.bigint "cart_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_id", null: false
    t.integer "number_of_pax"
    t.date "check_in"
    t.bigint "slot_id", null: false
    t.index ["cart_id"], name: "index_appointments_on_cart_id"
    t.index ["service_id"], name: "index_appointments_on_service_id"
    t.index ["slot_id"], name: "index_appointments_on_slot_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.integer "contact_number"
    t.bigint "payment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_id", null: false
    t.bigint "address_id", null: false
    t.bigint "appointment_id", null: false
    t.index ["address_id"], name: "index_bookings_on_address_id"
    t.index ["appointment_id"], name: "index_bookings_on_appointment_id"
    t.index ["payment_id"], name: "index_bookings_on_payment_id"
    t.index ["service_id"], name: "index_bookings_on_service_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "author"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "image"
    t.bigint "admin_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_user_id"], name: "index_categories_on_admin_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "street"
    t.string "barangay"
    t.string "city"
    t.string "province"
    t.integer "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "amount"
    t.string "pay_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "service_details"
    t.string "image"
    t.integer "price"
    t.bigint "admin_user_id", null: false
    t.bigint "category_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["admin_user_id"], name: "index_services_on_admin_user_id"
    t.index ["category_id"], name: "index_services_on_category_id"
    t.index ["location_id"], name: "index_services_on_location_id"
  end

  create_table "slots", force: :cascade do |t|
    t.string "start_time"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_id", null: false
    t.integer "slot_per_timeslot"
    t.string "end_time"
    t.index ["service_id"], name: "index_slots_on_service_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "add_on_books", "bookings"
  add_foreign_key "addresses", "users"
  add_foreign_key "adds_ons", "services"
  add_foreign_key "appointments", "carts"
  add_foreign_key "appointments", "services"
  add_foreign_key "appointments", "slots"
  add_foreign_key "appointments", "users"
  add_foreign_key "bookings", "addresses"
  add_foreign_key "bookings", "appointments"
  add_foreign_key "bookings", "payments"
  add_foreign_key "bookings", "services"
  add_foreign_key "carts", "users"
  add_foreign_key "categories", "admin_users"
  add_foreign_key "services", "admin_users"
  add_foreign_key "services", "categories"
  add_foreign_key "services", "locations"
  add_foreign_key "slots", "services"
end
