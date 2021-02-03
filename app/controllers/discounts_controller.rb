class DiscountsController < ApplicationController
  before_action :authenticate_sme_user!
  before_action :set_discount, only: [:show, :edit, :update, :destroy]
  before_action :validate_sme_user, only: [:new, :edit, :update, :destroy, :create]
  # GET /discounts
  # GET /discounts.json
  def index
    @discounts = current_sme_user.discounts
  end

  # GET /discounts/1
  # GET /discounts/1.json
  def show
  end

  # GET /discounts/new
  def new
    @discount = Discount.new
  end

  # GET /discounts/1/edit
  def edit
  end

  # POST /discounts
  # POST /discounts.json
  def create
    @discount = current_sme_user.discounts.new(discount_params)

    respond_to do |format|
      if @discount.save
        format.html { redirect_to discounts_url, notice: 'Discount was successfully created.' }
        format.json { render :show, status: :created, location: @discount }
      else
        format.html { render :new }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discounts/1
  # PATCH/PUT /discounts/1.json
  def update
    respond_to do |format|
      if @discount.update(discount_params)
        format.html { redirect_to discounts_url, notice: 'Discount was successfully updated.' }
        format.json { render :show, status: :ok, location: @discount }
      else
        format.html { render :edit }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discounts/1
  # DELETE /discounts/1.json
  def destroy
    @discount.destroy
    respond_to do |format|
      format.html { redirect_to discounts_url, notice: 'Discount was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discount
      @discount = current_sme_user.discounts.find_by_id(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def discount_params
      params.require(:discount).permit(:shopify_discount_code, :active, :shopify_discount_presents, :default, :product_ids)
    end
end
