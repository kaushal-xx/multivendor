class CreateVendorOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :vendor_orders do |t|
      t.references :vendor, null: false, foreign_key: true
      t.bigint :shopify_order_id
      t.json :shopify_order_data
      t.float :shopify_order_amount
      t.bigint :shopify_product_id
      t.integer :shopify_product_quantity
      t.bigint :shopify_variant_id
      t.references :vendor_product, null: false, foreign_key: true
      t.string :shopify_order_status

      t.timestamps
    end
  end
end
