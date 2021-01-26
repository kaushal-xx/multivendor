class Vendor < ApplicationRecord
  #=============== Module inclusions =============================
  include Utils
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :generate_vendor_code

  has_many :vendor_orders
  has_many :vendor_products
  has_many :vendor_variants
end
