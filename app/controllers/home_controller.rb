	# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user, except: [:varify_sme_user, :invoice, :download_invoice]
  layout "pdf", only: [:invoice, :download_invoice]
  def index
  	if current_admin.present?
  		Shop.set_store_session
  		@products = ShopifyAPI::Product.all
  	end
  end

  def profile

  end

  def sme
  	@sme_users = SmeUser.all
  end

  def edit_sme
  	@sme_user = SmeUser.find_by_id params[:sme_user_id]
  end

  def update_sme
  	sme_user = SmeUser.find_by_id params[:sme_user_id]
  	sme_user.update(active: params[:sme_user][:active])
  	redirect_to '/sme'
  end

  def vendor
  	@vendors = Vendor.all
  end

  def edit_vendor
  	@vendor = Vendor.find_by_id params[:vendor_id]
  end

  def update_vendor
  	puts params.inspect
  	vendor = Vendor.find_by_id params[:vendor_id]
  	vendor.update(active: params[:vendor][:active])
  	redirect_to '/vendor'
  end

  def sme_products
	Shop.set_store_session
	@products = ShopifyAPI::Product.all
  end

  def varify_sme_user
    Shop.set_store_session
    customer = ShopifyAPI::Customer.find(params[:customer_id])
    sme_user = SmeUser.active.find_by_email customer.email
    respond_to do |format|
    	if sme_user.present?
    		format.json { render json: 'Success', status: :ok}
    	else
    		format.json { render json: 'Faild', status: :ok}
    	end
    end
  end

  def invoice

  end

  def download_invoice
	send_file(
    	Order.last.generate_invoice,
    	filename: "your_custom_file_name.pdf",
    	type: "application/pdf"
  	)
  end
end
