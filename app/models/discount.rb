class Discount < ApplicationRecord

  attr_accessor :product_ids, :shopify_products

  #=============== Validations ===================================
  validates :shopify_discount_code, presence: true
  validates :shopify_discount_presents, presence: true
  validates :product_ids, presence: true
  validate :validate_shopify_discount_presents
  validate :validate_shopify_discount_code
  validate :validate_shopify_product_ids
  belongs_to :sme_user

  before_create :generate_shopify_code

  def generate_shopify_code
  	if self.shopify_discount_code.present?
  		Shop.set_store_session
  		price_rule = ShopifyAPI::PriceRule.create(title: self.shopify_discount_code,
        target_selection: 'entitled', 
        allocation_method: 'across', 
        value_type: 'percentage',
        value: self.shopify_discount_presents*-1, 
        target_type:'line_item',
        starts_at: Date.today,
        customer_selection: 'all',
        entitled_product_ids: self.shopify_products.map(&:id))
      if price_rule.id.present?
  			discount = ShopifyAPI::DiscountCode.create(price_rule_id: price_rule.id, code:  price_rule.title)
  			if discount.id.present?
  				self.shopify_discount_id = discount.id
  				self.shopify_price_rule_id = price_rule.id
  				self.shopify_discount_data = discount.attributes
  				self.shopify_price_rule_data = price_rule.attributes
  			end
  		end
  	end
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

  def validate_shopify_product_ids
    Shop.set_store_session
    self.shopify_products = ShopifyAPI::Product.find(:all, params:{handle: self.product_ids})
    self.shopify_product_ids = self.product_ids.split(',')
    missing_products = []
    self.product_ids.split(',').each do |p_id|
      missing_products << p_id if shopify_products.select{|s| s.handle == p_id}.blank?
    end
    if missing_products.present?
      errors.add(:base, "Product(#{missing_products.first}) is not available")
    end
  end
end
