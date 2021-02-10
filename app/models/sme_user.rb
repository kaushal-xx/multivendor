class SmeUser < ApplicationRecord

  #=============== Module inclusions =============================
  include Utils

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :generate_uniq_code
  before_create :set_default_max_commission

  has_many :orders
  has_many :draft_orders
  has_many :discounts
  has_many :delivery_addresses

  scope :active, -> { where(active: true) }

  before_save :generate_shopify_customer

  def generate_shopify_customer
    if self.shopify_customer_id.blank?
      Shop.set_store_session
      shopify_customer = ShopifyAPI::Customer.find(:all, params:{email: self.email}).first
      if shopify_customer.blank?
        shopify_customer = ShopifyAPI::Customer.new(email: 'kausha', first_name: self.name)
        shopify_customer.metafields = [{key: 'Role', value:'SME', value_type:'string', namespace: 'global'}]
        shopify_customer.tags = 'Role:SME'
        if self.id.blank? && self.password.present?
          shopify_customer.password = self.password
          shopify_customer.password_confirmation = self.password
        end
        if shopify_customer.save
          self.shopify_customer_id = shopify_customer.id
        end
      else
        if shopify_customer.metafields.select{|s| s.key=='Role'}.blank?
          shopify_customer.metafields = [{key: 'Role', value:'SME', value_type:'string', namespace: 'global'}]
          shopify_customer.tags = (shopify_customer.tags.split(',')+['Role:SME']).uniq.join(',')
          shopify_customer.save
        end
        self.shopify_customer_id = shopify_customer.id
      end
    end
  end

  def default_discount
  	discounts.where(active: true, default: true).first
  end

  def set_default_max_commission
  	self.max_commission = 5
  end
end
