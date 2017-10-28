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

ActiveRecord::Schema.define(version: 20171028141214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delivery_orders", force: :cascade do |t|
    t.string "order_id", null: false
    t.datetime "serving_datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_delivery_orders_on_order_id", unique: true
  end

  create_table "meals", force: :cascade do |t|
    t.string "name", null: false
    t.string "byline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "delivery_order_id"
    t.bigint "meal_id"
    t.integer "quantity", null: false
    t.integer "unit_price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_order_id"], name: "index_order_items_on_delivery_order_id"
    t.index ["meal_id"], name: "index_order_items_on_meal_id"
  end

  add_foreign_key "order_items", "delivery_orders"
  add_foreign_key "order_items", "meals"
end
