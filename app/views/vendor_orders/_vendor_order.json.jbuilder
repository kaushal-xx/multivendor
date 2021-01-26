json.extract! vendor_order, :id, :vendor_id, :shopify_order_id, :shopify_order_data, :shopify_order_amount, :shopify_product_id, :shopify_product_quantity, :shopify_variant_id, :product_id, :shopify_order_status, :created_at, :updated_at
json.url vendor_order_url(vendor_order, format: :json)
