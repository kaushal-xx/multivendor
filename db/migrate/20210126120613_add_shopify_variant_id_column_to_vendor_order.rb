class AddShopifyVariantIdColumnToVendorOrder < ActiveRecord::Migration[6.0]
  def change
  	add_column :vendor_orders, :shopify_line_item_total_price, :float
  	add_column :vendor_orders, :vendor_commission, :float
  end
end
