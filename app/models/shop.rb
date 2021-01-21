# frozen_string_literal: true
class Shop < ActiveRecord::Base
  include ShopifyApp::ShopSessionStorage

  def api_version
    ShopifyApp.configuration.api_version
  end

  def self.set_store_session
    shop_url = "https://#{Rails.application.credentials.dig(:shopify_api_shopprakritik_key).presence}:#{Rails.application.credentials.dig(:shopify_api_shopprakritik_password).presence}@#{Rails.application.credentials.dig(:shopify_api_shopprakritik_shop).presence}"
    ShopifyAPI::Base.site = shop_url
    ShopifyAPI::Base.api_version = ShopifyApp.configuration.api_version
  end
end
