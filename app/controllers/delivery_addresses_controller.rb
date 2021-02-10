class DeliveryAddressesController < ApplicationController
  before_action :set_delivery_address, only: [:show, :edit, :update, :destroy, :near_by]
  # GET /delivery_addresses
  # GET /delivery_addresses.json
  def index
    @delivery_addresses = current_sme_user.delivery_addresses
  end

  # GET /delivery_addresses/1
  # GET /delivery_addresses/1.json
  def show
  end

  # GET /delivery_addresses/new
  def new
    @delivery_address = DeliveryAddress.new(sme_user_id: current_sme_user.id)
  end

  # GET /delivery_addresses/1/edit
  def edit
  end

  # POST /delivery_addresses
  # POST /delivery_addresses.json
  def create
    @delivery_address = DeliveryAddress.new(delivery_address_params)
    @delivery_address.sme_user_id = current_sme_user.id
    respond_to do |format|
      if @delivery_address.save
        format.html { redirect_to delivery_addresses_url, notice: 'Delivery address was successfully created.' }
        format.json { render :show, status: :created, location: @delivery_address }
      else
        format.html { render :new }
        format.json { render json: @delivery_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delivery_addresses/1
  # PATCH/PUT /delivery_addresses/1.json
  def update
    respond_to do |format|
      if @delivery_address.update(delivery_address_params)
        format.html { redirect_to delivery_addresses_url, notice: 'Delivery address was successfully updated.' }
        format.json { render :show, status: :ok, location: @delivery_address }
      else
        format.html { render :edit }
        format.json { render json: @delivery_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_addresses/1
  # DELETE /delivery_addresses/1.json
  def destroy
    @delivery_address.destroy
    respond_to do |format|
      format.html { redirect_to delivery_addresses_url, notice: 'Delivery address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def near_by
    @vendors = @delivery_address.near_vendor
  end

  def near_by_products
     Shop.set_store_session
    @vendor = Vendor.find(params[:vendor_id])
    @products = @vendor.vendor_products
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery_address
      @delivery_address = DeliveryAddress.where(id: params[:id], sme_user_id: current_sme_user.id).first
    end

    # Only allow a list of trusted parameters through.
    def delivery_address_params
      params.require(:delivery_address).permit(:sme_user_id, :lat, :lon, :address1, :address2, :city, :state, :country, :pincode, :google_address)
    end
end
