class VendorProduct < ApplicationRecord

  attr_accessor :title, :body, :product_type, :image, :publish
  belongs_to :vendor
  has_many :vendor_variants
  has_many :vendor_orders

  #=============== Validations ===================================
  # validates :title, :body, :product_type, presence: true
  # before_create :generate_shopify_product
  # before_update :update_shopify_product
  # after_create :add_default_variant

  # def title
  # 	self.shopify_product_data['title']
  # end

  # def body
  # 	self.shopify_product_data['body_html']
  # end

  # def product_type
  # 	self.shopify_product_data['product_type']
  # end

  # def publish
  # 	self.shopify_product_data['published']
  # end

  def generate_shopify_product
  	if self.shopify_product_id.blank?
  		Shop.set_store_session
  		if self.image.present?
	  		image_data = File.read(self.image.tempfile)
	  		shopify_image = ShopifyAPI::Image.new
	  		shopify_image.attach_image(image_data)
	  	else
	  		shopify_image = nil
	  	end
  		shopify_product = ShopifyAPI::Product.new(title: self.title, body_html: self.body, vendor: self.vendor.code, product_type: self.product_type, published: self.publish=='1', images: [shopify_image])
      shopify_product.save
      if shopify_product.id.present?
				self.shopify_product_id = shopify_product.id
				self.shopify_product_data = shopify_product.attributes
				self.handle = shopify_product.handle
  	  end
  	end
  end

  def update_shopify_product
  	if self.shopify_product_id.present?
  		Shop.set_store_session
  		if self.image.present?
	  		image_data = File.read(self.image.tempfile)
	  		shopify_image = ShopifyAPI::Image.new
	  		shopify_image.attach_image(image_data)
	  	end
  		shopify_product = ShopifyAPI::Product.find self.shopify_product_id
  		shopify_product.title = self.title
  		shopify_product.body_html = self.body
  		shopify_product.vendor = self.vendor.code
  		shopify_product.product_type = self.product_type
  		shopify_product.published = self.publish == '1'
  		shopify_product.images << shopify_image if shopify_image.present?
      shopify_product.save
      if shopify_product.id.present?
				self.shopify_product_id = shopify_product.id
				self.shopify_product_data = shopify_product.attributes
				self.handle = shopify_product.handle
  	  end
  	end
  end

  def add_default_variant
  	shopify_product = ShopifyAPI::Product.find self.shopify_product_id
  	variant = shopify_product.variants.first
  	if variant.inventory_management != 'shopify'
  		variant.inventory_management = 'shopify'
  		variant.save
  	end
  	vendor_variant = vendor_variants.new(skip_validation: true, vendor_id: self.vendor_id, shopify_product_id: self.shopify_product_id, shopify_variant_id: variant.id, shopify_variant_data: variant.attributes, stock_count: 0, shopify_variant_price: variant.price, option1: variant.option1)
  	vendor_variant.save
  end

  def validate_shopify_discount_presents
    if self.shopify_discount_presents.blank? || self.shopify_discount_presents <= 0
      errors.add(:base, "Discount present should not less then Zero")
    elsif (sme_user.max_commission||0) < self.shopify_discount_presents
      errors.add(:base, "Discount present should be less then #{sme_user.max_commission||0}")
    end
  end

  def validate_shopify_discount_code
    if Discount.where(shopify_discount_code: self.shopify_discount_code).where.not(id: self.id).present?
      errors.add(:base, "Discount code already use")
    end
  end
end
