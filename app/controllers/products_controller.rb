# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_sme_user!
  def index
  	Shop.first.set_store_session
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
  end
end
