json.extract! vendor_address, :id, :vendor_id, :lat, :lon, :address1, :address2, :city, :state, :country, :pincode, :google_address, :created_at, :updated_at
json.url vendor_address_url(vendor_address, format: :json)
