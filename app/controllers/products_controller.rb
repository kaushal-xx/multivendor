# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_sme_user!
  def index
  	Shop.set_store_session
    @products = ShopifyAPI::Product.find(:all, params: { limit: 25 })
  end
end
