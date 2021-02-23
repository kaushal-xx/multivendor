class OrdersController < ApplicationController
  before_action :authenticate_sme_user!, except: [:download_invoice, :invoice]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  layout "pdf", only: [:invoice, :download_invoice]
  # GET /orders
  # GET /orders.json
  def index
    @orders = current_sme_user.orders.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def invoice
    Shop.set_store_session
    @order = Order.find_by_id params[:id]
    @shopify_order = ShopifyAPI::Order.find @order.shopify_order_id
  end

  def download_invoice
    order = Order.find_by_id params[:id]
    send_file(
      order.generate_invoice,
      filename: "your_custom_file_name.pdf",
      type: "application/pdf"
    )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = current_sme_user.order.find_by_id(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:shopify_order_id, :shopify_order_data, :sme_user_id, :shopify_order_amount, :sme_user_commission, :shopify_order_discount_amount)
    end
end
