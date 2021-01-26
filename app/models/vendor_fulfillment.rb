class VendorFulfillment < ApplicationRecord

  attr_accessor :tracking_number, :tracking_url, :quantity
  belongs_to :vendor
  belongs_to :vendor_order
  # belongs_to :vendor_product
  # belongs_to :vendor_variant

  #=============== Validations ===================================
  validates :quantity, presence: true

  before_validation :create_shopify_fulfillment

  def create_shopify_fulfillment
  	if quantity.present?
  		Shop.set_store_session
  		location = ShopifyAPI::Location.last
  		shopify_fulfillment = ShopifyAPI::Fulfillment.new(location_id: location.id, tracking_number: self.tracking_number, line_items: [{id: self.vendor_order.shopify_line_item_id, quantity: self.quantity}])
  		shopify_fulfillment.prefix_options = {order_id: self.vendor_order.shopify_order_id}
  		shopify_fulfillment.save
  		if shopify_fulfillment.id.present?
  			self.vendor = vendor_order.vendor
  			# self.vendor_product = vendor_order.vendor_product
  			# self.vendor_variant = vendor_order.vendor_variant
  			self.shopify_order_id = vendor_order.shopify_order_id
  			self.shopify_variant_id = vendor_order.shopify_variant_id
  			self.shopify_product_id = vendor_order.shopify_product_id
  			self.shopify_line_item_id = vendor_order.shopify_line_item_id
  			self.shopify_fulfillment_count = shopify_fulfillment.line_items.first.quantity
  			self.shopify_fulfillment_status = shopify_fulfillment.line_items.first.fulfillment_status
  			self.shopify_fulfillment_data = shopify_fulfillment.attributes
  		else
  			errors.add(:base, shopify_fulfillment.errors.full_messages.join(', '))
  		end
  	end
  end
end
