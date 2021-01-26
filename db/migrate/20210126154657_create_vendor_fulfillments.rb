class CreateVendorFulfillments < ActiveRecord::Migration[6.0]
  def change
    create_table :vendor_fulfillments do |t|
      t.references :vendor, null: false, foreign_key: true
      t.references :vendor_order, null: false, foreign_key: true
      t.bigint :shopify_order_id
      t.bigint :shopify_variant_id
      t.bigint :shopify_product_id
      t.bigint :shopify_line_item_id
      t.json :shopify_fulfillment_data
      t.integer :shopify_fulfillment_count
      t.string :shopify_fulfillment_status

      t.timestamps
    end
  end
end
