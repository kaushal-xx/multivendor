json.extract! vendor_fulfillment, :id, :vendor_id, :vendor_order_id, :shopify_order_id, :shopify_variant_id, :shopify_product_id, :shopify_line_item_id, :shopify_fulfillment_data, :shopify_fulfillment_count, :shopify_fulfillment_status, :shopify_variant_price, :created_at, :updated_at
json.url vendor_fulfillment_url(vendor_fulfillment, format: :json)
