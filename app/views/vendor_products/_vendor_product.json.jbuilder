json.extract! vendor_product, :id, :vendor_id, :shopify_product_id, :shopify_variant_id, :shopify_product_data, :stock_count, :shopify_product_price, :shopify_variant_price, :created_at, :updated_at
json.url vendor_product_url(vendor_product, format: :json)
