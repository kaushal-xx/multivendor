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
        sme_user = SmeUser.active.find_by_reference_code reference_code
        if sme_user.present?
            puts "***********2***********"
            order = Order.find_by_shopify_order_id params[:id]
            if order.blank?
                puts "***********3***********"
                order = sme_user.orders.new(shopify_order_id: params[:id], shopify_order_data: params, shopify_order_amount: params[:total_price], shopify_order_discount_amount: params[:total_discounts])
                order_total_value = order.shopify_order_amount.to_f + order.shopify_order_discount_amount.to_f
                sme_commission = 0.0
                total_app_commission = 0.0
                total_app_commission_tax = 0.0
                total_sme_commission_tax = 0.0
                total_discount = 0.0
                config = Config.first
                params[:line_items].each do |line_item|
                    total_tax_per = line_item[:tax_lines].map{|s| s[:rate].to_f}.sum||0.0
                    product = Product.find_by_shopify_product_id(line_item[:product_id])
                    if product.present? && product.application_commission > 0
                        application_commission = product.application_commission
                    else
                        application_commission = config.app_commission
                    end
                    total_price_line_item = (line_item[:quantity].to_i*line_item[:price].to_f)
                    app_commission =  ((application_commission.to_f/100) * total_price_line_item.to_f)
                    if total_tax_per > 0
                        app_commission_tax = (total_tax_per.to_f * app_commission.to_f)
                    else
                        app_commission_tax = 0.0
                    end
                    if product.present? && product.sme_commission.present? && product.sme_commission > 0
                        sme_commission = sme_commission + ((product.sme_commission.to_f/100) * app_commission.to_f)
                        if total_tax_per > 0
                            sme_commission_tax = (total_tax_per.to_f * sme_commission.to_f)
                        else
                            sme_commission_tax = 0.0
                        end
                        total_sme_commission_tax = total_sme_commission_tax + sme_commission_tax
                        total_discount = total_discount + line_item[:total_discount].to_f
                    end
                    total_app_commission = total_app_commission + app_commission
                    total_app_commission_tax = total_app_commission_tax + app_commission_tax
                end
                if sme_commission > total_discount
                    sme_commission = sme_commission - total_discount.to_f
                else
                    sme_commission = 0.0
                end
                order.sme_user_commission = sme_commission.round(2)
                order.app_commission = total_app_commission.round(2)
                order.app_commission_tax = total_app_commission_tax.round(2)
                order.sme_user_commission_tax = total_sme_commission_tax.round(2)
                order.save
            end
        end
    end
    params[:line_items].each do |line_item|
        puts "**********************"
        puts line_item[:id]
        puts line_item[:variant_id]
        puts line_item[:quantity]
        puts line_item[:fulfillment_status]
        puts line_item[:price]
        puts line_item[:total_discount]
        puts line_item[:vendor]
        puts line_item[:properties]
        puts "*********************"
        vendor_code = (line_item[:properties].select{|k| k['name']=='vendor_code'}.first||{})['value']
        if vendor_code.present?
            vendor = Vendor.active.find_by_code vendor_code
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
                vendor_variant.update(stock_count: (vendor_variant.stock_count-line_item[:quantity].to_i))
            end
        end
    end
    render json: {message: "Order created"}, status: :ok
  end
end
