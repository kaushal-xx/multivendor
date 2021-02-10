class VendorAddress < ApplicationRecord
  belongs_to :vendor

  def distance(delivery_address)
	current_location = Geokit::LatLng.new(delivery_address.lat, delivery_address.lon)
	destination = "#{self.lat},#{self.lon}"
	current_location.distance_to(destination).round(2)
  end
end
