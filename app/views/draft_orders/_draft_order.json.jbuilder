json.extract! draft_order, :id, :shopify_order_id, :shopify_order_data, :sme_user_id, :status, :created_at, :updated_at
json.url draft_order_url(draft_order, format: :json)
