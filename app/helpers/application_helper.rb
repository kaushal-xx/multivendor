module ApplicationHelper

	def product_url(product)
		@default_discount ||= current_sme_user.default_discount
		if @default_discount.present?
			"https://#{Shop.first.shopify_domain}/products/#{product.handle}?reference_code=#{current_sme_user.reference_code}&discount_code=#{@default_discount.shopify_discount_code}"
		else
			"https://#{Shop.first.shopify_domain}/products/#{product.handle}?reference_code=#{current_sme_user.reference_code}"
		end
	end

	def chart_labels
		months = {1 => "Jan", 2 => "Feb", 3 => "Mar", 4 => "Apr", 5 => "May", 6 => "Jun", 7 => "Jul", 8 => "Aug", 9 => "Sep", 10 => "Oct", 11 => "Nov", 12 => "Dec"}
		date = Date.today
		data = []
		(1..6).each do |i|
			data << months[date.month]
			date = date - 1.month
		end
		data
	end
end
