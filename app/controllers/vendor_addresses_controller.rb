class VendorAddressesController < ApplicationController
  before_action :set_vendor_address, only: [:show, :edit, :update, :destroy]
  # GET /vendor_addresses
  # GET /vendor_addresses.json
  def index
    @vendor_addresses = VendorAddress.all
  end

  # GET /vendor_addresses/1
  # GET /vendor_addresses/1.json
  def show
  end

  # GET /vendor_addresses/new
  def new
    @vendor_address = VendorAddress.new(vendor_id: current_vendor.id)
  end

  # GET /vendor_addresses/1/edit
  def edit
  end

  # POST /vendor_addresses
  # POST /vendor_addresses.json
  def create
    @vendor_address = VendorAddress.new(vendor_address_params)
    @vendor_address.vendor_id = current_vendor.id
    respond_to do |format|
      if @vendor_address.save
        format.html { redirect_to @vendor_address, notice: 'Vendor address was successfully created.' }
        format.json { render :show, status: :created, location: @vendor_address }
      else
        format.html { render :new }
        format.json { render json: @vendor_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendor_addresses/1
  # PATCH/PUT /vendor_addresses/1.json
  def update
    respond_to do |format|
      if @vendor_address.update(vendor_address_params)
        format.html { redirect_to @vendor_address, notice: 'Vendor address was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor_address }
      else
        format.html { render :edit }
        format.json { render json: @vendor_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_addresses/1
  # DELETE /vendor_addresses/1.json
  def destroy
    @vendor_address.destroy
    respond_to do |format|
      format.html { redirect_to vendor_addresses_url, notice: 'Vendor address was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_address
      @vendor_address = VendorAddress.where(id: params[:id], vendor_id: current_vendor.id).first
    end

    # Only allow a list of trusted parameters through.
    def vendor_address_params
      params.require(:vendor_address).permit(:vendor_id, :lat, :lon, :address1, :address2, :city, :state, :country, :pincode, :google_address)
    end
end
