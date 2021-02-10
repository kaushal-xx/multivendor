class DeliveryAddress < ApplicationRecord
	belongs_to :sme_user

  def near_vendor(min_distance = 20)
  	vendors = []
  	Vendor.joins(:vendor_address).active.each do |vendor|
  		if vendor.vendor_address.present?
			vaddress = vendor.vendor_address
			current_location = Geokit::LatLng.new(self.lat, self.lon)
			destination = "#{vaddress.lat},#{vaddress.lon}"
			if current_location.distance_to(destination) <= min_distance
				vendors << vendor
			end
		end
  	end
  	vendors
  end
end
