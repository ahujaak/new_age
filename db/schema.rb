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

ActiveRecord::Schema.define(version: 2022_09_03_140030) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drivers", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name"
    t.string "email", null: false
    t.string "phone"
    t.text "address"
    t.integer "paylater_limit", default: 0
    t.integer "used_paylater_amount", default: 0
    t.date "paylater_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_drivers_on_email"
  end

  create_table "order_adjustments", force: :cascade do |t|
    t.string "adjustment_type", null: false
    t.decimal "amount", default: "0.0", null: false
    t.text "description"
    t.bigint "order_id", null: false
    t.bigint "driver_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["driver_id"], name: "index_order_adjustments_on_driver_id"
    t.index ["order_id"], name: "index_order_adjustments_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.decimal "fuel_quantity", default: "0.0"
    t.decimal "price", default: "0.0"
    t.decimal "total_amount", default: "0.0"
    t.boolean "pay_later", default: true
    t.text "comment"
    t.bigint "payment_method_id"
    t.bigint "driver_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["driver_id"], name: "index_orders_on_driver_id"
    t.index ["payment_method_id"], name: "index_orders_on_payment_method_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.integer "method_type"
    t.string "card_number"
    t.date "card_expriy"
    t.string "account_number"
    t.string "bank_name"
    t.string "ifsc"
    t.boolean "verified", default: false
    t.boolean "default", default: false
    t.bigint "driver_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["driver_id"], name: "index_payment_methods_on_driver_id"
  end

  add_foreign_key "order_adjustments", "drivers"
  add_foreign_key "order_adjustments", "orders"
  add_foreign_key "orders", "drivers"
  add_foreign_key "payment_methods", "drivers"
end
