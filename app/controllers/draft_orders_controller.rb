class DraftOrdersController < ApplicationController
  before_action :authenticate_sme_user!, except: [:create]
  before_action :set_draft_order, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, :only => [:create]
  before_action :validate_sme_user, only: [:new, :edit, :update, :destroy, :create]


  # GET /draft_orders
  # GET /draft_orders.json
  def index
    @draft_orders = current_sme_user.draft_orders
  end

  # GET /draft_orders/1
  # GET /draft_orders/1.json
  def show
  end

  # GET /draft_orders/new
  def new
    @draft_order = DraftOrder.new
  end

  # GET /draft_orders/1/edit
  def edit
  end

  # POST /draft_orders
  # POST /draft_orders.json
  def create
    Shop.set_store_session
    customer = ShopifyAPI::Customer.find(params[:customer_id])
    sme_user = SmeUser.find_by_email customer.email
    if sme_user.present?
      data = []
      params[:items].each do |key, item|
        data << {variant_id: item[:variant_id], quantity: item[:quantity]}
      end
      Shop.set_store_session
      @shopify_draft_order = ShopifyAPI::DraftOrder.new(line_items: data, note_attributes: [{name: 'reference_code', value: sme_user.reference_code}])
    end

    respond_to do |format|
      if sme_user.present? && @shopify_draft_order.present? && @shopify_draft_order.save
        DraftOrder.create(sme_user: sme_user, shopify_order_id: @shopify_draft_order.id, shopify_order_data: @shopify_draft_order.attributes)
        format.html { redirect_to draft_orders_url, notice: 'Draft order was successfully created.' }
        format.json { render json: 'Success', status: :created}
      else
        format.json { render json: 'errors', status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /draft_orders/1
  # PATCH/PUT /draft_orders/1.json
  def update
    respond_to do |format|
      if @draft_order.update(draft_order_params)
        format.html { redirect_to @draft_order, notice: 'Draft order was successfully updated.' }
        format.json { render :show, status: :ok, location: @draft_order }
      else
        format.html { render :edit }
        format.json { render json: @draft_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /draft_orders/1
  # DELETE /draft_orders/1.json
  def destroy
    @draft_order.destroy
    respond_to do |format|
      format.html { redirect_to draft_orders_url, notice: 'Draft order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_draft_order
      @draft_order = DraftOrder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def draft_order_params
      params.require(:draft_order).permit(:shopify_order_id, :shopify_order_data, :sme_user_id, :status)
    end
end
