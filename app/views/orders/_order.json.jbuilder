json.extract! order, :id, :shopify_order_id, :shopify_order_data, :sme_user_id, :shopify_order_amount, :sme_user_commission, :shopify_order_discount_amount, :created_at, :updated_at
json.url order_url(order, format: :json)
