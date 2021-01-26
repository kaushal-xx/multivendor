class AddVendorVariantColumnToVendorOrder < ActiveRecord::Migration[6.0]
  def change
  	add_column :vendor_orders, :vendor_variant_id, :integer
  	add_column :vendor_orders, :shopify_line_item_price, :float
  	add_column :vendor_orders, :shopify_line_item_discount, :float
  end
end
