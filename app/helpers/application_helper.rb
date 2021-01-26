module ApplicationHelper

	def product_url(product)
		if current_sme_user.present?
			sme_user_product_url(product)
		else
			vendor_product_url(product)
		end
	end

	def vendor_product_url(product)
		"https://#{Rails.application.credentials.dig(:shopify_api_shopprakritik_shop).presence}/products/#{product.handle}"
	end

	def sme_user_product_url(product)
		@default_discount ||= current_sme_user.default_discount
		if @default_discount.present?
			"https://#{Rails.application.credentials.dig(:shopify_api_shopprakritik_shop).presence}/products/#{product.handle}?reference_code=#{current_sme_user.reference_code}&discount_code=#{@default_discount.shopify_discount_code}"
		else
			"https://#{Rails.application.credentials.dig(:shopify_api_shopprakritik_shop).presence}/products/#{product.handle}?reference_code=#{current_sme_user.reference_code}"
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
