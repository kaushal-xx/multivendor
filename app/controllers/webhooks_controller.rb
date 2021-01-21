# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token 
  def order_create
    Shop.first.set_store_session
    puts "**********************"
    puts params[:id]
    puts "*********************"
    shopify_order = ShopifyAPI::Order.find params[:id]
    reference_code = shopify_order.note_attributes.select{|key| key.name == 'reference_code'}.first.try(:value)
    if reference_code.present?
        sme_user = SmeUser.find_by_reference_code reference_code
        if sme_user.present?
            order = Order.find_by_shopify_order_id shopify_order.id
            if order.blank?
                order = sme_user.orders.new(shopify_order_id: shopify_order.id, shopify_order_data: params, shopify_order_amount: shopify_order.total_price, shopify_order_discount_amount: shopify_order.total_discounts)
                order_total_value = order.shopify_order_amount.to_f + order.shopify_order_discount_amount.to_f
                sme_commission = (sme_user.max_commission.to_f/100) * order_total_value.to_f
                if sme_commission > order.shopify_order_discount_amount.to_f
                    sme_commission = sme_commission - order.shopify_order_discount_amount.to_f
                else
                    sme_commission = 0.0
                end
                order.sme_user_commission = sme_commission
                order.save
            end
        end
    end
    render :nothing => true, :status => 200
  end
end
