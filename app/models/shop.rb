# frozen_string_literal: true
class Shop < ActiveRecord::Base
  include ShopifyApp::ShopSessionStorage

  def api_version
    ShopifyApp.configuration.api_version
  end

  def set_store_session
    ShopifyAPI::Base.clear_session
    session=Shop.retrieve(self.id)
    ShopifyAPI::Base.activate_session(session)
  end
end
