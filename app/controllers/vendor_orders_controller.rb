class VendorOrdersController < ApplicationController
  before_action :authenticate_vendor!
  before_action :set_vendor_order, only: [:show, :edit, :update, :destroy]

  # GET /vendor_orders
  # GET /vendor_orders.json
  def index
    @orders = current_vendor.vendor_orders
  end

  # GET /vendor_orders/1
  # GET /vendor_orders/1.json
  def show
  end

  # GET /vendor_orders/new
  def new
    @vendor_order = current_vendor.vendor_orders.new
  end

  # GET /vendor_orders/1/edit
  def edit
  end

  # POST /vendor_orders
  # POST /vendor_orders.json
  def create
    @vendor_order = current_vendor.vendor_orders.new(vendor_order_params)

    respond_to do |format|
      if @vendor_order.save
        format.html { redirect_to @vendor_order, notice: 'Vendor order was successfully created.' }
        format.json { render :show, status: :created, location: @vendor_order }
      else
        format.html { render :new }
        format.json { render json: @vendor_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendor_orders/1
  # PATCH/PUT /vendor_orders/1.json
  def update
    respond_to do |format|
      if @vendor_order.update(vendor_order_params)
        format.html { redirect_to @vendor_order, notice: 'Vendor order was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor_order }
      else
        format.html { render :edit }
        format.json { render json: @vendor_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_orders/1
  # DELETE /vendor_orders/1.json
  def destroy
    @vendor_order.destroy
    respond_to do |format|
      format.html { redirect_to vendor_orders_url, notice: 'Vendor order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_order
      @vendor_order = current_vendor.vendor_orders.find_by_id(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vendor_order_params
      params.require(:vendor_order).permit(:vendor_id, :shopify_order_id, :shopify_order_data, :shopify_order_amount, :shopify_product_id, :shopify_product_quantity, :shopify_variant_id, :product_id, :shopify_order_status)
    end
end
