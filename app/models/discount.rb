class Discount < ApplicationRecord

  #=============== Validations ===================================
  validates :shopify_discount_code, presence: true
  validates :shopify_discount_presents, presence: true
  validate :validate_shopify_discount_presents
  validate :validate_shopify_discount_code
  belongs_to :sme_user

  before_create :generate_shopify_code

  def generate_shopify_code
  	if self.shopify_discount_code.present?
  		Shop.first.set_store_session
  		price_rule = ShopifyAPI::PriceRule.create(title: self.shopify_discount_code, target_selection: 'all', allocation_method: 'across', value_type: 'percentage', value: self.shopify_discount_presents*-1, target_type:'line_item',starts_at: Date.today, customer_selection: 'all')
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
end
