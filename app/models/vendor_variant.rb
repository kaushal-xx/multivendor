class VendorVariant < ApplicationRecord

  attr_accessor :option1, :image, :price, :skip_validation
  belongs_to :vendor
  belongs_to :vendor_product
  has_many :vendor_orders

  #=============== Validations ===================================
  validates :option1, presence: true
  before_validation :generate_shopify_variant

  after_create :update_shopify_product
  after_update :update_shopify_variant_stock

  def generate_shopify_variant
    if self.skip_validation.blank?
      Shop.set_store_session
      if self.shopify_variant_id.blank?
        if self.image.present?
          image_data = File.read(self.image.tempfile)
          shopify_image = ShopifyAPI::Image.new
          shopify_image.attach_image(image_data)
          shopify_image.prefix_options = {product_id: self.vendor_product.shopify_product_id}
          shopify_image.save
        end
        shopify_variant = ShopifyAPI::Variant.new(option1: self.option1, price: self.price, product_id: self.vendor_product.shopify_product_id, inventory_management: 'shopify')
        shopify_variant.image_id = shopify_image.id if shopify_image.present?
        shopify_variant.save
        if shopify_variant.id.present?
          self.shopify_product_id = self.vendor_product.shopify_product_id
          self.shopify_variant_id = shopify_variant.id
          self.shopify_variant_data = shopify_variant.attributes
          self.shopify_variant_price = shopify_variant.price
        else
          errors.add(:base, shopify_variant.errors.full_messages.join(', '))
        end
      else
        if self.image.present?
          image_data = File.read(self.image.tempfile)
          shopify_image = ShopifyAPI::Image.new
          shopify_image.attach_image(image_data)
          shopify_image.prefix_options = {product_id: self.vendor_product.shopify_product_id}
          shopify_image.save
        end
        shopify_variant = ShopifyAPI::Variant.find self.shopify_variant_id
        shopify_variant.image_id = shopify_image.id if shopify_image.present?
        shopify_variant.option1 = self.option1
        shopify_variant.price = self.price
        shopify_variant.save
        if shopify_variant.errors.blank?
          self.shopify_product_id = self.vendor_product.shopify_product_id
          self.shopify_variant_id = shopify_variant.id
          self.shopify_variant_data = shopify_variant.attributes
          self.shopify_variant_price = shopify_variant.price
        else
          errors.add(:base, shopify_variant.errors.full_messages.join(', '))
        end
      end
    end
  end

  def update_shopify_product
    Shop.set_store_session
    shopify_product = ShopifyAPI::Product.find self.vendor_product.shopify_product_id
    self.vendor_product.update_columns(shopify_product_data: shopify_product.attributes)
  end

  def update_shopify_variant_stock
    Shop.set_store_session
    shopify_variant = ShopifyAPI::Variant.find self.shopify_variant_id
    params = { inventory_item_ids: shopify_variant.inventory_item_id }
    inventory_levels = ShopifyAPI::InventoryLevel.find(:all, params: params)
    inventory_levels[0].adjust self.stock_count
    reload_shopify_variant_stock(shopify_variant)
  end

  def reload_shopify_variant_stock(shopify_variant = nil)
    if shopify_variant.blank?
      Shop.set_store_session
      shopify_variant = ShopifyAPI::Variant.find self.shopify_variant_id
    end
    self.update_columns(stock_count: shopify_variant.reload.inventory_quantity)
  end

  def default_image
    (self.vendor_product.shopify_product_data['images'].select{|s| s['id'] == self.shopify_variant_data['image_id']}.first||{})['src']
  end
end
