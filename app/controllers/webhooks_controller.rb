# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token 
  def order_create
    Shop.set_store_session
    puts "**********************"
    puts params[:id]
    puts params[:note_attributes]
    puts params[:total_price]
    puts params[:total_discounts]
    puts "*********************"
    reference_code = ((params[:note_attributes]||[]).select{|key| key['name'] == 'reference_code'}.first||{})['value']
    if reference_code.present?
        puts "***********1***********"
        sme_user = SmeUser.find_by_reference_code reference_code
        if sme_user.present?
            puts "***********2***********"
            order = Order.find_by_shopify_order_id params[:id]
            if order.blank?
                puts "***********3***********"
                order = sme_user.orders.new(shopify_order_id: params[:id], shopify_order_data: params, shopify_order_amount: params[:total_price], shopify_order_discount_amount: params[:total_discounts])
                order_total_value = order.shopify_order_amount.to_f + order.shopify_order_discount_amount.to_f
                sme_commission = (sme_user.max_commission.to_f/100) * order_total_value.to_f
                if sme_commission > order.shopify_order_discount_amount.to_f
                    sme_commission = sme_commission - order.shopify_order_discount_amount.to_f
                else
                    sme_commission = 0.0
                end
                order.sme_user_commission = sme_commission.round(2)
                order.save
            end
        end
    end
    render json: {message: "Order created"}, status: :ok
  end
end
