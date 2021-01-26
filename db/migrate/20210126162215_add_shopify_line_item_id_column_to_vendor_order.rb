class AddShopifyLineItemIdColumnToVendorOrder < ActiveRecord::Migration[6.0]
  def change
  	add_column :vendor_orders, :shopify_line_item_id, :bigint
  end
end
