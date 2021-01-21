module ApplicationHelper

	def product_url(product)
		@default_discount ||= current_sme_user.default_discount
		if @default_discount.present?
			"https://#{Shop.first.shopify_domain}/products/#{product.handle}?reference_code=#{current_sme_user.reference_code}&discount_code=#{@default_discount.shopify_discount_code}"
		else
			"https://#{Shop.first.shopify_domain}/products/#{product.handle}?reference_code=#{current_sme_user.reference_code}"
		end
	end
end
