class VendorProductsController < ApplicationController
  before_action :authenticate_vendor!
  before_action :set_vendor_product, only: [:show, :edit, :update, :destroy]

  # GET /vendor_products
  # GET /vendor_products.json
  def index
    @products = current_vendor.vendor_products.where.not(shopify_product_id: nil)
  end

  # GET /vendor_products/1
  # GET /vendor_products/1.json
  def show
  end

  # GET /vendor_products/new
  def new
    @product = current_vendor.vendor_products.new
  end

  # GET /vendor_products/1/edit
  def edit
  end

  # POST /vendor_products
  # POST /vendor_products.json
  def create
    @product = current_vendor.vendor_products.new(vendor_product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to vendor_products_url, notice: 'product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendor_products/1
  # PATCH/PUT /vendor_products/1.json
  def update
    respond_to do |format|
      if @product.update(vendor_product_params)
        format.html { redirect_to vendor_products_url, notice: 'Vendor product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_products/1
  # DELETE /vendor_products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to vendor_products_url, notice: 'Vendor product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_product
      @product = current_vendor.vendor_products.find_by_id(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vendor_product_params
      params.require(:vendor_product).permit(:title, :body, :product_type, :image, :publish)
    end
end
