# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_21_050008) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "discounts", force: :cascade do |t|
    t.bigint "shopify_discount_id"
    t.json "shopify_discount_data"
    t.bigint "sme_user_id", null: false
    t.string "shopify_discount_code"
    t.boolean "active"
    t.float "shopify_discount_presents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "shopify_price_rule_id"
    t.json "shopify_price_rule_data"
    t.boolean "default", default: false
    t.index ["sme_user_id"], name: "index_discounts_on_sme_user_id"
  end

  create_table "order_discounts", force: :cascade do |t|
    t.bigint "discount_id", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["discount_id"], name: "index_order_discounts_on_discount_id"
    t.index ["order_id"], name: "index_order_discounts_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "shopify_order_id"
    t.json "shopify_order_data"
    t.bigint "sme_user_id", null: false
    t.float "shopify_order_amount"
    t.float "sme_user_commission"
    t.float "shopify_order_discount_amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sme_user_id"], name: "index_orders_on_sme_user_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "sme_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "shopify_customer_id"
    t.string "shopify_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "max_commission"
    t.string "reference_code"
    t.boolean "active", default: false
    t.string "name"
    t.index ["email"], name: "index_sme_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_sme_users_on_reset_password_token", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.bigint "shopify_user_id", null: false
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shopify_user_id"], name: "index_users_on_shopify_user_id", unique: true
  end

  add_foreign_key "discounts", "sme_users"
  add_foreign_key "order_discounts", "discounts"
  add_foreign_key "order_discounts", "orders"
  add_foreign_key "orders", "sme_users"
end
