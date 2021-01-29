class Product < ApplicationRecord

	validates :sme_commission, presence: true
	validate :validate_sme_commission_presents

  after_save :generate_shopify_product

  def generate_shopify_product
  	if self.shopify_product_id.present?
		Shop.set_store_session
		shopify_product = ShopifyAPI::Product.find self.shopify_product_id
		shopify_product.save
		if shopify_product.id.present?
			self.shopify_product_id = shopify_product.id
			self.shopify_product_data = shopify_product.attributes
			self.shopify_handle = shopify_product.handle
		end
  	end
  end

  def validate_sme_commission_presents
    if self.sme_commission.blank? || self.sme_commission < 0
      errors.add(:base, "Discount present should not less then Zero")
    end
  end
end
