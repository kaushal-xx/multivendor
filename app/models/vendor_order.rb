class VendorOrder < ApplicationRecord
  belongs_to :vendor
  belongs_to :vendor_product
  belongs_to :vendor_variant

  has_many :generate_shopify_product


  def generate_shopify_product
  	if self.shopify_product_id.present?
		Shop.set_store_session
		shopify_product = ShopifyAPI::Product.find self.shopify_product_id
		shopify_product.save
		if shopify_product.id.present?
			self.shopify_product_id = shopify_product.id
			self.shopify_product_data = shopify_product.attributes
			self.handle = shopify_product.handle
		end
  	end
  end
end
