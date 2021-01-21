class SmeUser < ApplicationRecord

  #=============== Module inclusions =============================
  include Utils

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :generate_uniq_code

  has_many :orders
  has_many :discounts

  def default_discount
  	discounts.where(active: true, default: true).first
  end
end
