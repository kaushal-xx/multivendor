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
                sme_commission = 0.0
                total_discount = 0.0
                params[:line_items].each do |line_item|
                    product = Product.find_by_shopify_product_id(line_item[:product_id])
                    if product.present? && product.sme_commission.present? && product.sme_commission > 0
                        total_price_line_item = (line_item[:quantity].to_i*line_item[:price].to_f)
                        sme_commission = sme_commission + (product.sme_commission.to_f/100) * total_price_line_item.to_f
                        total_discount = total_discount + line_item[:total_discount].to_f
                    end
                end
                if sme_commission > total_discount
                    sme_commission = sme_commission - total_discount.to_f
                else
                    sme_commission = 0.0
                end
                order.sme_user_commission = sme_commission.round(2)
                order.save
            end
        end
    else
        params[:line_items].each do |line_item|
            puts "**********************"
            puts line_item[:id]
            puts line_item[:variant_id]
            puts line_item[:quantity]
            puts line_item[:fulfillment_status]
            puts line_item[:price]
            puts line_item[:total_discount]
            puts line_item[:vendor]
            puts "*********************"
            vendor_variant = VendorVariant.find_by_shopify_variant_id line_item[:variant_id]
            if vendor_variant.present?
                vendor = Vendor.find_by_code line_item[:vendor]
                if vendor.present?
                    if vendor.vendor_orders.where(shopify_order_id: params[:id], shopify_variant_id: line_item[:variant_id]).blank?
                        puts "**********Save************"
                        puts line_item.inspect
                        puts "**********************"
                        order = vendor_variant.vendor_orders.new(vendor_product: vendor_variant.vendor_product, 
                            shopify_variant_id: line_item[:variant_id],
                            vendor: vendor_variant.vendor, 
                            shopify_order_id: params[:id], 
                            shopify_line_item_id: line_item[:id],
                            shopify_order_data: params, 
                            shopify_order_amount: params[:total_price], 
                            shopify_product_quantity: line_item[:quantity],
                            shopify_order_status: line_item[:fulfillment_status],
                            shopify_line_item_price: line_item[:price],
                            shopify_line_item_discount: line_item[:total_discount],
                            shopify_line_item_total_price: (line_item[:quantity].to_i*line_item[:price].to_f),
                            vendor_commission: (line_item[:quantity].to_i*line_item[:price].to_f) - line_item[:total_discount].to_f)
                        if order.save
                            puts "**********Saveed************"
                            puts order.id
                            puts "**********************"
                        else
                            puts "**********Faild************"
                            puts order.inspect
                            puts "**********************"
                        end
                    end
                    vendor_variant.reload_shopify_variant_stock
                end

            end
        end
    end
    render json: {message: "Order created"}, status: :ok
  end
end
