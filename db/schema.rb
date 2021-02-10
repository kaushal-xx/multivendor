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

ActiveRecord::Schema.define(version: 2021_02_10_030409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "configs", force: :cascade do |t|
    t.float "app_commission"
    t.float "sme_commission"
    t.string "app_title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "delivery_addresses", force: :cascade do |t|
    t.bigint "sme_user_id", null: false
    t.string "lat"
    t.string "lon"
    t.text "address1"
    t.text "address2"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "pincode"
    t.text "google_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sme_user_id"], name: "index_delivery_addresses_on_sme_user_id"
  end

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
    t.text "shopify_product_ids", default: [], array: true
    t.index ["sme_user_id"], name: "index_discounts_on_sme_user_id"
  end

  create_table "draft_orders", force: :cascade do |t|
    t.bigint "shopify_order_id"
    t.json "shopify_order_data"
    t.bigint "sme_user_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sme_user_id"], name: "index_draft_orders_on_sme_user_id"
  end

  create_table "invoicing_ledger_items", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "recipient_id"
    t.string "type"
    t.datetime "issue_date"
    t.string "currency", limit: 3, null: false
    t.decimal "total_amount", precision: 20, scale: 4
    t.decimal "tax_amount", precision: 20, scale: 4
    t.string "status", limit: 20
    t.string "identifier", limit: 50
    t.string "description"
    t.datetime "period_start"
    t.datetime "period_end"
    t.string "uuid", limit: 40
    t.datetime "due_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["recipient_id"], name: "index_invoicing_ledger_items_on_recipient_id"
    t.index ["sender_id"], name: "index_invoicing_ledger_items_on_sender_id"
  end

  create_table "invoicing_line_items", force: :cascade do |t|
    t.bigint "ledger_item_id"
    t.string "type"
    t.decimal "net_amount", precision: 20, scale: 4
    t.decimal "tax_amount", precision: 20, scale: 4
    t.string "description"
    t.string "uuid", limit: 40
    t.datetime "tax_point"
    t.decimal "quantity", precision: 20, scale: 4
    t.integer "creator_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ledger_item_id"], name: "index_invoicing_line_items_on_ledger_item_id"
  end

  create_table "invoicing_tax_rates", force: :cascade do |t|
    t.string "description"
    t.decimal "rate", precision: 20, scale: 4
    t.datetime "valid_from", null: false
    t.datetime "valid_until"
    t.integer "replaced_by_id"
    t.boolean "is_default"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.float "app_commission", default: 0.0
    t.float "app_commission_tax", default: 0.0
    t.float "sme_user_commission_tax", default: 0.0
    t.index ["sme_user_id"], name: "index_orders_on_sme_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "shopify_product_id"
    t.string "shopify_handle"
    t.float "sme_commission"
    t.json "shopify_product_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "application_commission", default: 0.0
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

  create_table "vendor_addresses", force: :cascade do |t|
    t.bigint "vendor_id", null: false
    t.string "lat"
    t.string "lon"
    t.text "address1"
    t.text "address2"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "pincode"
    t.text "google_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vendor_id"], name: "index_vendor_addresses_on_vendor_id"
  end

  create_table "vendor_fulfillments", force: :cascade do |t|
    t.bigint "vendor_id", null: false
    t.bigint "vendor_order_id", null: false
    t.bigint "shopify_order_id"
    t.bigint "shopify_variant_id"
    t.bigint "shopify_product_id"
    t.bigint "shopify_line_item_id"
    t.json "shopify_fulfillment_data"
    t.integer "shopify_fulfillment_count"
    t.string "shopify_fulfillment_status"
    t.float "shopify_variant_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["vendor_id"], name: "index_vendor_fulfillments_on_vendor_id"
    t.index ["vendor_order_id"], name: "index_vendor_fulfillments_on_vendor_order_id"
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
    t.bigint "shopify_line_item_id"
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

  add_foreign_key "delivery_addresses", "sme_users"
  add_foreign_key "discounts", "sme_users"
  add_foreign_key "draft_orders", "sme_users"
  add_foreign_key "order_discounts", "discounts"
  add_foreign_key "order_discounts", "orders"
  add_foreign_key "orders", "sme_users"
  add_foreign_key "vendor_addresses", "vendors"
  add_foreign_key "vendor_fulfillments", "vendor_orders"
  add_foreign_key "vendor_fulfillments", "vendors"
  add_foreign_key "vendor_orders", "vendor_products"
  add_foreign_key "vendor_orders", "vendors"
  add_foreign_key "vendor_products", "vendors"
  add_foreign_key "vendor_variants", "vendor_products"
  add_foreign_key "vendor_variants", "vendors"
end
