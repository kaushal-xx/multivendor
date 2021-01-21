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
  has_many :discounts

  def default_discount
  	discounts.where(active: true, default: true).first
  end

  def set_default_max_commission
  	self.max_commission = 5
  end
end
