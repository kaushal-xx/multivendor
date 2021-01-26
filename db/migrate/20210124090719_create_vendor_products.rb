class CreateVendorProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :vendor_products do |t|
      t.references :vendor, null: false, foreign_key: true
      t.bigint :shopify_product_id
      t.bigint :shopify_variant_id
      t.json :shopify_product_data
      t.integer :stock_count
      t.float :shopify_product_price
      t.float :shopify_variant_price

      t.timestamps
    end
  end
end
