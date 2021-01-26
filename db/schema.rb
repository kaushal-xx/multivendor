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

ActiveRecord::Schema.define(version: 2021_01_26_120613) do

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

  create_table "vendor_orders", force: :cascade do |t|
    t.bigint "vendor_id", null: false
    t.bigint "shopify_order_id"
    t.json "shopify_order_data"
    t.float "shopify_order_amount"
    t.bigint "shopify_product_id"
    t.integer "shopify_product_quantity"
    t.bigint "shopify_variant_id"
    t.bigint "vendor_product_id", null: false
    t.string "shopify_order_status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "vendor_variant_id"
    t.float "shopify_line_item_price"
    t.float "shopify_line_item_discount"
    t.float "shopify_line_item_total_price"
    t.float "vendor_commission"
    t.index ["vendor_id"], name: "index_vendor_orders_on_vendor_id"
    t.index ["vendor_product_id"], name: "index_vendor_orders_on_vendor_product_id"
  end

  create_table "vendor_products", force: :cascade do |t|
    t.bigint "vendor_id", null: false
    t.bigint "shopify_product_id"
    t.bigint "shopify_variant_id"
    t.json "shopify_product_data"
    t.integer "stock_count"
    t.float "shopify_product_price"
    t.float "shopify_variant_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "handle"
    t.index ["vendor_id"], name: "index_vendor_products_on_vendor_id"
  end

  create_table "vendor_variants", force: :cascade do |t|
    t.bigint "vendor_id", null: false
    t.bigint "vendor_product_id", null: false
    t.bigint "shopify_product_id"
    t.bigint "shopify_variant_id"
    t.json "shopify_variant_data"
    t.integer "stock_count"
    t.float "shopify_variant_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vendor_id"], name: "index_vendor_variants_on_vendor_id"
    t.index ["vendor_product_id"], name: "index_vendor_variants_on_vendor_product_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.float "max_commission"
    t.float "float"
    t.string "reference_code"
    t.boolean "active", default: false
    t.string "uniq_code"
    t.string "string"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
    t.index ["email"], name: "index_vendors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_vendors_on_reset_password_token", unique: true
  end

  add_foreign_key "discounts", "sme_users"
  add_foreign_key "order_discounts", "discounts"
  add_foreign_key "order_discounts", "orders"
  add_foreign_key "orders", "sme_users"
  add_foreign_key "vendor_orders", "vendor_products"
  add_foreign_key "vendor_orders", "vendors"
  add_foreign_key "vendor_products", "vendors"
  add_foreign_key "vendor_variants", "vendor_products"
  add_foreign_key "vendor_variants", "vendors"
end
