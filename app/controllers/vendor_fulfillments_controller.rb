class VendorFulfillmentsController < ApplicationController
  before_action :set_vendor_fulfillment, only: [:show, :edit, :update, :destroy]
  before_action :set_order
  # GET /vendor_fulfillments
  # GET /vendor_fulfillments.json
  def index
    @vendor_fulfillments = @order.vendor_fulfillments
  end

  # GET /vendor_fulfillments/1
  # GET /vendor_fulfillments/1.json
  def show
  end

  # GET /vendor_fulfillments/new
  def new
    @vendor_fulfillment = @order.vendor_fulfillments.new
  end

  # GET /vendor_fulfillments/1/edit
  def edit
  end

  # POST /vendor_fulfillments
  # POST /vendor_fulfillments.json
  def create
    @vendor_fulfillment = @order.vendor_fulfillments.new(vendor_fulfillment_params)
    @vendor_fulfillment.vendor = current_vendor
    respond_to do |format|
      if @vendor_fulfillment.save
        format.html { redirect_to vendor_order_vendor_fulfillments_path(@order), notice: 'Vendor fulfillment was successfully created.' }
        format.json { render :show, status: :created, location: @vendor_fulfillment }
      else
        format.html { render :new }
        format.json { render json: @vendor_fulfillment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendor_fulfillments/1
  # PATCH/PUT /vendor_fulfillments/1.json
  def update
    respond_to do |format|
      if @vendor_fulfillment.update(vendor_fulfillment_params)
        format.html { redirect_to vendor_order_vendor_fulfillments_path(@order), notice: 'Vendor fulfillment was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor_fulfillment }
      else
        format.html { render :edit }
        format.json { render json: @vendor_fulfillment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_fulfillments/1
  # DELETE /vendor_fulfillments/1.json
  def destroy
    @vendor_fulfillment.destroy
    respond_to do |format|
      format.html { redirect_to vendor_order_vendor_fulfillments_path(@order), notice: 'Vendor fulfillment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_fulfillment
      @vendor_fulfillment = @order.vendor_fulfillments.find_by_id(params[:id])
    end

    def set_order
      @order = current_vendor.vendor_orders.find_by_id params[:vendor_order_id]
    end

    # Only allow a list of trusted parameters through.
    def vendor_fulfillment_params
      params.require(:vendor_fulfillment).permit(:tracking_number, :tracking_url, :quantity)
    end
end
