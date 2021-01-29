json.extract! product, :id, :shopify_product_id, :shopify_handle, :sme_commission, :shopify_product_data, :created_at, :updated_at
json.url product_url(product, format: :json)
