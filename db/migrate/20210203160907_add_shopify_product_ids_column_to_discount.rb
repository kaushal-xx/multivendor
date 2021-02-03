class AddShopifyProductIdsColumnToDiscount < ActiveRecord::Migration[6.0]
  def change
  	add_column :discounts, :shopify_product_ids, :text, array:true, default: []
  end
end
