class VendorVariantsController < ApplicationController
  before_action :set_vendor_variant, only: [:show, :edit, :update, :destroy]
  before_action :set_vendor_product
  before_action :validate_vendor, only: [:new, :edit, :update, :destroy, :create]

  # GET /vendor_variants
  # GET /vendor_variants.json
  def index
    @vendor_variants = @product.vendor_variants.all
  end

  # GET /vendor_variants/1
  # GET /vendor_variants/1.json
  def show
  end

  # GET /vendor_variants/new
  def new
    @vendor_variant = @product.vendor_variants.new
  end

  # GET /vendor_variants/1/edit
  def edit
  end

  # POST /vendor_variants
  # POST /vendor_variants.json
  def create
    @vendor_variant = @product.vendor_variants.new(vendor_variant_params)
    @vendor_variant.vendor_id = current_vendor.id
    respond_to do |format|
      if @vendor_variant.save
        format.html { redirect_to vendor_product_vendor_variants_url(@product), notice: 'Vendor variant was successfully created.' }
        format.json { render :show, status: :created, location: @vendor_variant }
      else
        format.html { render :new }
        format.json { render json: @vendor_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vendor_variants/1
  # PATCH/PUT /vendor_variants/1.json
  def update
    respond_to do |format|
      if @vendor_variant.update(vendor_variant_params)
        format.html { redirect_to vendor_product_vendor_variants_url(@product), notice: 'Vendor variant was successfully updated.' }
        format.json { render :show, status: :ok, location: @vendor_variant }
      else
        format.html { render :edit }
        format.json { render json: @vendor_variant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vendor_variants/1
  # DELETE /vendor_variants/1.json
  def destroy
    @vendor_variant.destroy
    respond_to do |format|
      format.html { redirect_to vendor_variants_url, notice: 'Vendor variant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor_variant
      @vendor_variant = VendorVariant.find(params[:id])
    end

    def set_vendor_product
      @product = current_vendor.vendor_products.find(params[:vendor_product_id])
    end

    # Only allow a list of trusted parameters through.
    def vendor_variant_params
      params.require(:vendor_variant).permit(:stock_count, :option1, :image, :price)
    end
end
