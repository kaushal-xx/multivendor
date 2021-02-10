json.extract! delivery_address, :id, :lat, :lon, :address1, :address2, :city, :state, :country, :pincode, :google_address, :created_at, :updated_at
json.url delivery_address_url(delivery_address, format: :json)
